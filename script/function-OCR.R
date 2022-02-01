function(pathway, output_name){
  # libraries
  p <- c("tesseract", "magick", "pdftools")
  lapply(p, library, character.only = T)
  
  # get languages required (eng is automatic)
  tesseract_download("fra") # only necessary once
  
  # load language dictionaries
  eng <- tesseract("eng")
  fr <- tesseract("fra")
  
  # convert pdf to high res png 
  pngfile <- pdf_convert(pathway, dpi = 600)
  
  # preprocess png for optimal conditions and perform ocr
  text <- lapply(pngfile,  function(x) image_read(x) %>%
    image_modulate(brightness = 80, saturation = 120, hue = 90) %>%
    image_contrast(sharpen = 5) %>%
    image_enhance() %>%
    image_write(format = 'png', density = '300x300') %>%
    tesseract::ocr()
    )
  
  # save
  write.table(text, paste0("pdf/Cleaned/", output_name, ".txt"))

}