#install.packages('tesseract', 'magick', 'pdftools')
p <- c("tesseract", "magick", "pdftools")
lapply(p, library, character.only = T)
#tesseract_download("fra") # only necessary once

# load language dictionaries
eng <- tesseract("eng")
fr <- tesseract("fra")

# convert pdf to high res png 
pngfile <- pdf_convert("pdf/Parc/VM166-D01901-56_op parc Louis-Cyr.pdf", pages = 5:10, dpi = 600)

# preprocess png for optimal conditions 
text <- image_read(pngfile) %>%
  image_modulate(brightness = 80, saturation = 120, hue = 90) %>%
  image_contrast(sharpen = 5) %>%
  image_enhance() %>%
  image_write(format = 'png', density = '300x300') %>%
  tesseract::ocr() 

# use optimal character recognition 
text <- ocr(pngfile)
text <- list(text)
