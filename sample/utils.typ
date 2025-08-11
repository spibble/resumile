#import "@preview/fontawesome:0.6.0": *

/*
* -----
* Helper fns.
* -----
*/
#let format_gpa(num) = {
  let fmts = (int, float, str)
  
  assert(
    fmts.contains(type(num)), 
    message: "GPA should be a numeric type (i.e., int, float) or string.")
  
  if type(num) == int [ #num.00 ] 
  else if type(num) == float [ #num ]
  else {
    // grab part of string that's just #.##
    let numeric_num = float(num.split(regex("[^[+-]?\d*\.?\d+$]")).first())
    [#numeric_num]
  }
}

#let better_link(url, proj: none) = {
  assert(
    type(url) == str, 
    message: "url should be a string.")

  if proj == none {
    if "https://www." in url { link(url)[#url.slice(12)] }
    else if "https://" in url { link(url)[#url.slice(8)] }
    else if "www." in url { link(url)[#url.slice(4)] }
    else { link("https://" + url)[#url] }
  } else if proj == "live" { link(url)[Live] 
  } else { link(url)[Source Code]
  }
  
}

/*
* -----
* Document-wide formatting
* -----
*/
#let section_line() = {
  v(-3pt);
  line(length: 100%);
  v(-5pt);
}

#let section(name) = {
  heading(level: 2, name)
  section_line()
}

#let conf(
  margin_x, margin_y,
  name_font_size, info_font_size, heading_font_size, body_font_size,
  name_font, info_font, heading_font, body_font,
  name_color, heading_color, show_icons,
  doc
) = {
  set page(
    paper: "us-letter",
    margin: (x: margin_x, y: margin_y)
  )

  show heading.where(level: 1): set text(name_color, name_font_size, font: name_font)
  show heading.where(level: 2): set text(heading_color, heading_font_size, font: heading_font)
  set text(font: body_font)

  set text(body_font_size, font: body_font)
  set par(spacing: 1.2em)
  show link: underline

  doc
}

/*
* -----
* Header formatting
* -----
*/
#let header(
  name, loc, phone, email, 
  website, linkedin, github,
  info_font, info_font_size, header_style, show_icons
) = {
  if header_style == 0 and show_icons == true {
    table(
      columns: (2fr, auto),
      align: (left + horizon, right + horizon),
      stroke: none,
      inset: 0pt,
      [= #name],
      [ #set text(info_font_size, font: info_font)
        #fa-icon("location-dot", fill: red) #loc #h(0.2cm)
        #fa-icon("phone-square", fill: green) #phone #h(0.2cm)
        #fa-icon("square-envelope", fill: teal) #link("mailto:" + email)
        \
        #if website != "" [
          #fa-icon("globe", fill: eastern) #better_link(website) 
        ]
        #if linkedin != "" [
          #h(0.3cm) 
          #fa-icon("linkedin", fill: blue) #better_link(linkedin)
        ]
        #if github != "" [
          #h(0.3cm)
          #fa-icon("github") #better_link(github)
        ]
      ]
    )
  } else if header_style == 0 {
    table(
      columns: (2fr, auto),
      align: (left + horizon, right + horizon),
      stroke: none,
      inset: 0pt,
      [= #name],
      [ #set text(info_font_size, font: info_font)
        #loc | #phone | #link("mailto:" + email)
        \
        #if website != "" [ #better_link(website) ]
        #if (website != "" and linkedin != "") or (website != "" and github != "") [ | ]
        #if linkedin != "" [ #better_link(linkedin) ]
        #if (linkedin != "" and github != "") [ | ]
        #if github != "" [ #better_link(github) ]
      ]
    )
  } else if header_style == 1 and show_icons == true {
    [
      #set align(center)
      #set text(info_font_size, font: info_font)
  
      = #name
      #fa-icon("location-dot", fill: red) 
        #loc
        #h(0.2cm)
      #fa-icon("phone-square", fill: green) 
        #phone
        #h(0.2cm)
      #fa-icon("square-envelope", fill: teal) 
        #link("mailto:" + email)
        #h(0.2cm)
      #if website != "" [
        #fa-icon("globe", fill: eastern) #better_link(website) 
      ]
      #if linkedin != "" [
        #if website != "" [ #h(0.2cm) ] 
        #fa-icon("linkedin", fill: blue) #better_link(linkedin)
      ]
      #if github != "" [
        #if (website != "" or linkedin != "") [ #h(0.2cm) ]
        #fa-icon("github") #better_link(github)
      ]
    ]
  } else {
    [
      #set align(center)
      #set text(info_font_size, font: info_font)
  
      = #name
        #loc | #phone | #link("mailto:" + email)
        #if (website != "" or linkedin != "" or github != "") [ | ]
        #if website != "" [ #better_link(website) ]
        #if (website != "" and linkedin != "") or (website != "" and github != "") [ | ]
        #if linkedin != "" [ #better_link(linkedin) ]
        #if (linkedin != "" and github != "") [ | ]
        #if github != "" [ #better_link(github) ]
    ]
  }
}

/*
* -----
* Education section formatting
* -----
*/
#let education(
  school: "", 
  grad_date: "", 
  degree: "", 
  loc: "",
  gpa: none
) = {
  [
    *#school* #h(1fr) #grad_date \
    #degree
    #if gpa != none {
      [| #format_gpa(gpa) GPA]
    } #h(1fr) #loc
  ]
}

#let coursework(content) = {
  [ - *Relevant Coursework*: #content ]
}

/*
* -----
* Experience section formatting
* -----
*/
#let experience(
  role: none,
  dates: none,
  employer: none, 
  location: none, 
  contents: none
) = {
  for param in (role, dates, employer, location) {
    if param != none {
      assert(
        type(param) == str,
        message: "all parameter values should be strings - double check!"
      )
    }

    if contents != none {
      assert(
        type(contents) == content,
        message: "contents should be a content block (i.e., encased in square brackets)"
      )
    }
  }
  
  [
    *#role* #h(1fr) #dates \
    #employer #h(1fr) #location
  ]
  [ #contents ]
}

#let multi_role_experience(
  roles: none,
  dates: none,
  employer: none,
  location: none,
  contents: ""
) = {
  for param in (roles, dates, contents) {
    if param != none {
      assert(
        type(param) == array,
        message: "roles, dates, and contents should be arrays - double check these values!"
      )
    }
  }

  [*#employer* #h(1fr) #location \ ]

  for (i, role) in roles.enumerate() {
    [
      #role #h(1fr) #dates.at(i) \
      #contents.at(i)
    ]
  }
}

/*
* -----
* Projects section formatting
* -----
*/

// Links take precedence over dates, so if you include both, it will only show the links.
#let project(
  name: none,
  tools: none,
  live_link: none,
  source_link: none,
  date: none,
  contents: none
) = {
  for param in (name, tools) {
    if param != none {
      assert(
        type(param) == str,
        message: "name and tools should be strings - double check those values."
      )
    }
  }

  for param in (live_link, source_link) {
    if param != none {
      assert(
        type(param) == str,
        message: "links"
      )
    }
  }
  
  [ *#name* | #tools #h(1fr) ] 

  if live_link != none or source_link != none {
    if live_link != none and source_link != none {
      [ #fa-icon("globe", fill:eastern) #better_link(live_link, proj: "live") | #fa-icon("github") #better_link(source_link, proj: "source") ]
    } else if live_link != none {
      [ #fa-icon("globe", fill:eastern) #better_link(live_link, proj: "live")[asd] ]
    } else {
      [ #fa-icon("github") #better_link(source_link, proj: "source")]
    }
  } else if date != none [ #date ] 

  if content != none [ \ #contents ]
}

/*
* -----
* Skills section formatting
* -----
*/
#let skills(
  lists: none,
  contents: none
) = {
  for (i, list) in lists.enumerate() {
    [*#list*: #contents.at(i) \ ]
  }
}
