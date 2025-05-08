#text sentiment---
# Find out more about building applications with Shiny her
#
#library----
# 确保所有依赖包显式加载
if (!require("textdata")) install.packages("textdata")
if (!require("tidytext")) install.packages("tidytext")
library(tidytext)

library(textdata)
library(shiny)
library(ggplot2)
library(readxl)
library(tidytext)
library(tidyverse)
library(bslib)
library(lubridate)
library(zip)
library(openxlsx)
library(writexl)
library(httr)
library(ggsci)

#设定上传文件容量。----
options(shiny.maxRequestSize = 50 * 1024 ^ 3)


#UI----


ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "zephyr"),
  #https://bootswatch.com/ choose preference theme #zephyr
  titlePanel("Text Sentiment Project"),
  
  
  tabsetPanel(
    
    tabPanel(
      "TEXT INPUT",
      hr(),
      
      fluidRow(
        column(
          width = 8,
          textAreaInput(
            "text_input", 
            "Text input", 
            value = "Fill here with text",
            height = "360px"
          )),
        column(
          width = 4,
          textInput(
            "stopwords_input",
            "Custom Stopwords (comma separated)",
            value = "don, father, mother"
          )),
        column(
          width = 4,
          sliderInput(
            "n_sentences_paragraph",
            "Set Sentences Each Paragraph",
            min = 1,
            max = 10,
            value = 1
          ))
      ),
      
      hr(),
      
      
      
      
      
      DT::dataTableOutput("TextEmotion_df"),
      downloadButton("Download_TextEmotion_df", "Download The Table"),
      hr(),
      
      textOutput("text_merge_sentiment"),
      
      DT::dataTableOutput("WordsSentiments_df"),
      
      hr(),
      
      DT::dataTableOutput("NumberWordsSentiments_df"),#每一行的不同情绪的词数
      hr(),
      
      plotOutput("WordsSentiments_plot"),
      hr(),
      DT::dataTableOutput("PositiveWord_df")
      
    ) 
    
  )
)







# Server----
server <- function(input, output, session) {
  
  
  #这里需要修改把？ 在processed_text()函数前添加----
  

  
  
  
  # 处理自定义停用词
  custom_stop_words <- reactive({
    # 基础停用词
    base_stops <- tidytext::stop_words %>%
      bind_rows(
        tibble(
          word = c("don", "stark", "mother"),
          lexicon = "custom"
        )
      )
    
    # 处理用户输入
    if(nchar(input$stopwords_input) > 0) {
      user_stops <- strsplit(input$stopwords_input, "\\s*,\\s*")[[1]] %>%
        tibble(
          word = .,
          lexicon = "user_custom"
        )
      
      base_stops <- bind_rows(base_stops, user_stops)
    }
    
    return(base_stops)
  })
  
  
  
  processed_text <- reactive({
    req(input$text_input)  # 确保输入不为空
    
    # 创建包含输入文本的tibble
    text_tibble <- tibble(
      full_text = input$text_input # 获取输入文本
    )
    
    
    

    
    
    # 执行分词和停用词操作
    text_tibble %>%
      unnest_tokens(
        output = sentence_text,    # 输出列名,包含句子
        input = full_text,      # 输入列名
        token = "sentences",   # 按句子分割
        to_lower = F         # 暂时不转小写，以保证句子分割的准确性
      ) %>% 
      mutate(sentence_id = row_number()) %>% # 为每个句子分配一个唯一的ID
      unnest_tokens(
        output = word,          # 输出列名，包含单个词
        input = sentence_text,  # 输入列名，包含单个句子
        token = "words",        # 按词分割
        to_lower = TRUE         # 在分词时转为小写
      ) %>%
      anti_join(custom_stop_words(), by = "word") %>% # 添自定义停用词过滤
      anti_join(stop_words) %>% #添加词库停用词
      select(sentence_id, word) # 选择我们需要的列：句子ID和词
  })
  
  # 渲染交互式表格
  output$TextEmotion_df <- DT::renderDataTable({
    DT::datatable(
      processed_text(),
      caption = tags$caption(style = 'caption-side: top; font-size: 1.2em;',
                             "Each partitioning words"),
      options = list(scrollX = TRUE, pageLength = 5, dom = 'ftip', # 显示功能元素
                     autoWidth = TRUE,  # 自动列宽
                     responsive = TRUE  # 启用响应式       
      ),
      style = "bootstrap",
      rownames = FALSE,     # 隐藏行号
      width = "100%"  # 设置表格宽度
    ) %>% 
      DT::formatStyle(columns = names(processed_text()), 
                      fontSize = '14px')  # 设置字体大小
  })
  
  
  
  # 下载处理器
  output$Download_TextEmotion_df <- downloadHandler(
    filename = function() {
      paste("text-tokens-sentences-", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(processed_text(), file, row.names = FALSE)
    }
  )
  
  
  
  
  output$text_merge_sentiment <- renderText({
    "Using the emotional dictionary to merge with words"
  })
  
  
  
  
  output$WordsSentiments_df <- DT::renderDataTable({
    DT::datatable(
      processed_text() %>% 
        inner_join(get_sentiments("nrc")) %>% 
        arrange(sentence_id),
      caption = tags$caption(style = 'caption-side: top; font-size: 1.2em;',
                             "Words Merge with Sentiment"),
      options = list(scrollX = TRUE, pageLength = 5, dom = 'ftip', # 显示功能元素
                     autoWidth = TRUE,  # 自动列宽
                     responsive = TRUE  # 启用响应式       
      ),
      style = "bootstrap",
      rownames = FALSE,     # 隐藏行号
      width = "100%"  # 设置表格宽度
      
      
    )
    
  })
  
  output$NumberWordsSentiments_df <- DT::renderDataTable({
    DT::datatable(
      processed_text() %>% 
        inner_join(get_sentiments("nrc"), by = "word") %>% 
        count(sentence_id, sentiment) %>%
        mutate(index = sentence_id %/% input$n_sentences_paragraph ) %>% #每5句话1个段落
        arrange(index), 
      caption = tags$caption(style = 'caption-side: top; font-size: 1.2em;',
                             "Sentiment compare with paragraph index"),
      options = list(scrollX = TRUE, pageLength = 5, dom = 'ftip', # 显示功能元素
                     autoWidth = TRUE,  # 自动列宽
                     responsive = TRUE  # 启用响应式       
      ),
      style = "bootstrap",
      rownames = FALSE,     # 隐藏行号
      width = "100%"  # 设置表格宽度
    )
    
  })#可以看到每个段落的情感丰富情况
  
  
  output$WordsSentiments_plot <- renderPlot({
    processed_text() %>% 
      anti_join(custom_stop_words()) %>% 
      inner_join(get_sentiments("nrc")) %>% 
      filter(sentiment != "negative" & sentiment != "positive") %>% 
      count(sentence_id, sentiment) %>% 
      mutate(index = sentence_id %/% input$n_sentences_paragraph ) %>%
      ggplot(aes(x= index, y = n, fill = sentiment)) +
      geom_col() +
      facet_wrap(~ sentiment, ncol = 3) +
      labs(title = "Sentiment Distribution by Paragraph",
           x = paste("Paragraph Index (", input$n_sentences_paragraph, "sentences per paragraph)"),
           y = "Word Count") +
      theme_minimal(base_size = 14)+ # 基础字体大小
      ggsci::scale_fill_lancet(alpha = 0.8)+
      theme(
        plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 12),
        strip.text = element_text(size = 12, face = "bold"),
        legend.text = element_text(size = 12),
        panel.spacing = unit(1, "lines")
      )
  })
  
  #接下来看看出现次数最多的正面和负面情感词分别由，先看看正面情感词 按照词频来排序
  
  output$PositiveWord_df <- DT::renderDataTable({
    DT::datatable(
      processed_text() %>% 
        inner_join(get_sentiments("nrc"), by = "word") %>% 
        filter(sentiment == "positive") %>% 
        count(word) %>% 
        arrange(desc(n)),
      
      caption = tags$caption(style = 'caption-side: top; font-size: 1.2em;',
                             "Top Positive Sentiment Words"),
      options = list(scrollX = TRUE, pageLength = 5, dom = 'ftip', # 显示功能元素
                     autoWidth = TRUE,  # 自动列宽
                     responsive = TRUE  # 启用响应式       
      ),
      style = "bootstrap",
      rownames = FALSE,     # 隐藏行号
      width = "100%"  # 设置表格宽度
    )
    
    
  })
  
  
  
  
  
  
  
  
}#结束server





shinyApp(ui = ui, server = server)