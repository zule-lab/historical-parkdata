install.packages('tesseract', 'magick', 'pdftools')
p <- c("tesseract", "magick", "pdftools")
lapply(p, library, character.only = T)
#tesseract_download("fra") # only necessary once

# load language dictionaries
eng <- tesseract("eng")
fr <- tesseract("fra")

# convert pdf to high res png 
pngfile <- pdf_convert("C:/Users/I_RICHMO/Downloads/VM166-D01901-56_op parc Louis-Cyr.pdf", dpi = 600)

# preprocess png for optimal conditions 
text <- input %>%
  image_resize("2000x") %>%
  image_convert(type = 'Grayscale') %>%
  image_trim(fuzz = 40) %>%
  image_write(format = 'png', density = '300x300') %>%
  tesseract::ocr() 

# use optimal character recognition 
text <- ocr(pngfile)
cat(text)
