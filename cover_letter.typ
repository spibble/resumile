#import "utils.typ": conf, header, section
#import "resume.typ": margin_x, margin_y, name_font_size, info_font_size, heading_font_size, body_font_size,name_font, info_font, heading_font, body_font, name, loc, phone, email, website, linkedin, github, info_font, info_font_size, header_style
  
#show: doc => conf(
  margin_x, margin_y,
  name_font_size, info_font_size, heading_font_size, body_font_size,
  name_font, info_font, heading_font, body_font,
  doc
)

#header(
  name, loc, phone, email, 
  website, linkedin, github,
  info_font, info_font_size, header_style
)

#section("")


