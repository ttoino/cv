// Adapted from https://github.com/DeveloperPaul123/modern-cv/blob/b15709fbf61ca42090ff251b7b1870f646adf5f6/lib.typ

#import "@preview/catppuccin:1.0.1": catppuccin, flavors
#import "@preview/linguify:0.4.2": *

#let flavor = flavors.latte

// const color
#let color-darknight = flavor.colors.subtext1.rgb
#let color-darkgray = flavor.colors.subtext0.rgb
#let color-gray = flavor.colors.crust.rgb
#let default-accent-color = flavor.colors.blue.rgb
#let default-location-color = flavor.colors.crust.rgb

// const icons
#let icon(body) = box(baseline: .1em, body)

#let address-icon = icon[\u{e0c8}]
#let birth-icon = icon[\u{e7e9}]
#let bitbucket-icon = icon[\u{F00A8}]
#let email-icon = icon[\u{e158}]
#let github-icon = icon[\u{F02A4}]
#let gitlab-icon = icon[\u{F0BA0}]
#let google-scholar-icon = icon[\u{e80c}]
#let homepage-icon = icon[\u{e88a}]
#let link-icon = icon[\u{e89e}]
#let linkedin-icon = icon[\u{F033B}]
#let orcid-icon = icon[id]
#let phone-icon = icon[\u{e0b0}]
#let twitter-icon = icon[\u{F0544}]
#let website-icon = icon[\u{e894}]

/// Helpers

// Common helper functions
#let __format_author_name(author) = str(author.firstname) + " " + str(author.lastname)

#let __apply_smallcaps(content, use-smallcaps) = {
  if use-smallcaps {
    smallcaps(content)
  } else {
    content
  }
}

// layout utility
#let __justify_align(left_body, right_body) = {
  block({
    left_body
    box(width: 1fr, align(right, right_body))
  })
}

#let __justify_align_3(left_body, mid_body, right_body) = {
  block({
    box(width: 1fr, align(left, left_body))
    box(width: 1fr, align(center, mid_body))
    box(width: 1fr, align(right, right_body))
  })
}

#let __footer(document, author, language, date, use-smallcaps: true) = {
  set text(fill: flavor.colors.subtext1.rgb, size: 8pt)
  __justify_align_3(
    __apply_smallcaps(date, use-smallcaps),
    __apply_smallcaps(
      __format_author_name(author) + " · " + linguify(document),
      use-smallcaps,
    ),
    context counter(page).display(),
  )
}

#let __coverletter_footer = __footer.with("cover-letter")
#let __resume_footer = __footer.with("resume")

/// Show a link with an icon, specifically for Github projects
/// *Example*
/// #example(`resume.github-link("DeveloperPaul123/awesome-resume")`)
/// - github-path (string): The path to the Github project (e.g. "DeveloperPaul123/awesome-resume")
/// -> none
#let github-link(github-path, content) = {
  set box(height: 11pt)

  link("https://github.com/" + github-path)[
    #github-icon #content
  ]
}

/// Right section for the justified headers
/// - body (content): The body of the right header
#let secondary-right-header(body) = {
  set text(size: 11pt, weight: "medium")
  body
}

/// Right section of a tertiaty headers.
/// - body (content): The body of the right header
#let tertiary-right-header(body) = {
  set text(weight: "light", size: 9pt)
  body
}

/// Justified header that takes a primary section and a secondary section. The primary section is on the left and the secondary section is on the right.
/// - primary (content): The primary section of the header
/// - secondary (content): The secondary section of the header
#let justified-header(primary, secondary) = {
  set block(above: 0.7em, below: 0.7em)
  pad(__justify_align[
    == #primary
  ][
    #secondary-right-header[#secondary]
  ])
}

/// Justified header that takes a primary section and a secondary section. The primary section is on the left and the secondary section is on the right. This is a smaller header compared to the `justified-header`.
/// - primary (content): The primary section of the header
/// - secondary (content): The secondary section of the header
#let secondary-justified-header(primary, secondary) = {
  __justify_align[
    === #primary
  ][
    #tertiary-right-header[#secondary]
  ]
}
/// --- End of Helpers

/// ---- Resume Template ----

/// Resume template that is inspired by the Awesome CV Latex template by posquit0. This template can loosely be considered a port of the original Latex template.
///
/// The original template: https://github.com/posquit0/Awesome-CV
///
/// - author (dictionary): Structure that takes in all the author's information
/// - profile-picture (image): The profile picture of the author. This will be cropped to a circle and should be square in nature.
/// - date (string): The date the resume was created
/// - accent-color (color): The accent color of the resume
/// - colored-headers (boolean): Whether the headers should be colored or not
/// - language (string): The language of the resume, defaults to "en". See lang.toml for available languages
/// - use-smallcaps (boolean): Whether to use small caps formatting throughout the template
/// - show-address-icon (boolean): Whether to show the address icon
/// - description (str | none): The PDF description
/// - keywords (array | str): The PDF keywords
/// - body (content): The body of the resume
/// -> none
#let resume(
  author: (:),
  profile-picture: none,
  date: datetime.today().display("[month repr:long] [day], [year]"),
  accent-color: default-accent-color,
  colored-headers: true,
  show-footer: true,
  language: "en",
  font: "Roboto",
  header-font: "Roboto",
  paper-size: "a4",
  use-smallcaps: true,
  show-address-icon: false,
  description: none,
  keywords: (),
  body,
) = {
  show: catppuccin.with(flavor)

  if type(accent-color) == str {
    accent-color = rgb(accent-color)
  }

  let lang-data = toml("lang.toml")
  set-database(lang-data)

  let desc = if description == none [
    #linguify("resume", lang: language) #author.firstname #author.lastname
  ] else {
    description
  }

  show: body => context {
    set document(
      author: author.firstname + " " + author.lastname,
      title: linguify("resume", lang: language),
      description: desc,
      keywords: keywords,
    )
    body
  }

  set text(
    font: font,
    lang: language,
    size: 11pt,
    fallback: true,
  )

  set page(
    paper: paper-size,
    margin: (left: 15mm, right: 15mm, top: 10mm, bottom: 10mm),
    footer: if show-footer {
      __resume_footer(
        author,
        language,
        date,
        use-smallcaps: use-smallcaps,
      )
    } else {},
    footer-descent: 0pt,
  )

  // set paragraph spacing
  set par(spacing: 0.75em, justify: true)

  set heading(numbering: none, outlined: false)

  show heading.where(level: 1): it => {
    set text(size: 16pt, weight: "bold")
    set text(accent-color) if colored-headers
    set align(left)
    set block(above: 1em)

    [#it.body #box(width: 1fr, baseline: -0.5pt, line(length: 100%))]
  }

  show heading.where(level: 2): it => {
    set text(size: 12pt, weight: "bold")
    it.body
  }

  show heading.where(level: 3): it => {
    set text(size: 10pt, weight: "regular")
    __apply_smallcaps(it.body, use-smallcaps)
  }

  let name = {
    align(center, pad(bottom: 5pt, block[
      #set text(size: 32pt, style: "normal", font: header-font)
      #text(accent-color, weight: "thin", author.firstname)
      #text(weight: "bold", author.lastname)
    ]))
  }

  let positions = {
    set text(accent-color, size: 9pt, weight: "regular")
    align(center, __apply_smallcaps(
      author.positions.join(text[#"  "#sym.dot.c#"  "]),
      use-smallcaps,
    ))
  }

  let contacts = {
    set box(height: 9pt)

    let separator = box(width: 10pt)

    align(center, {
      set text(size: 9pt, weight: "regular", style: "normal")
      block(align(horizon, {
        if "address" in author {
          [#address-icon #author.address]
          separator
        }
        if "birth" in author {
          [#birth-icon #author.birth]
          separator
        }
        if "phone" in author {
          link("tel:" + author.phone)[#phone-icon #author.phone]
          separator
        }
        if "email" in author {
          link("mailto:" + author.email)[#email-icon #author.email]
        }
        if "homepage" in author {
          separator
          link(author.homepage)[#homepage-icon #author.homepage.trim(regex("^(https?://)?(www\\.)?"))]
        }
        if "github" in author {
          separator
          link("https://github.com/" + author.github)[#github-icon #author.github]
        }
        if "gitlab" in author {
          separator
          link("https://gitlab.com/" + author.gitlab)[#gitlab-icon #author.gitlab]
        }
        if "bitbucket" in author {
          separator
          link("https://bitbucket.org/" + author.bitbucket)[#bitbucket-icon #author.bitbucket]
        }
        if "linkedin" in author {
          separator
          link("https://www.linkedin.com/in/" + author.linkedin)[#linkedin-icon #author.firstname #author.lastname]
        }
        if "twitter" in author {
          separator
          link("https://twitter.com/" + author.twitter)[#twitter-icon \@#author.twitter]
        }
        if "scholar" in author {
          separator
          link(
            "https://scholar.google.com/citations?user=" + author.scholar,
          )[#google-scholar-icon #author.firstname #author.lastname]
        }
        if "orcid" in author {
          separator
          link("https://orcid.org/" + author.orcid)[#orcid-icon #author.orcid]
        }
        if "website" in author {
          separator
          link(author.website)[#website-icon #author.website.trim(regex("^(https?://)?(www\\.)?"))]
        }
        if "custom" in author and type(author.custom) == array {
          for item in author.custom {
            if "text" in item {
              let content = [#if "icon" in item { item.icon } #item.text]
              separator
              if "link" in item {
                link(item.link, content)
              } else {
                content
              }
            }
          }
        }
      }))
    })
  }

  if profile-picture != none {
    grid(
      columns: (100% - 4cm, 4cm),
      rows: 100pt,
      gutter: 10pt,
      {
        name
        positions
        contacts
      },
      align(left + horizon, block(
        clip: true,
        stroke: 0pt,
        radius: 2cm,
        width: 4cm,
        height: 4cm,
        profile-picture,
      )),
    )
  } else {
    name
    positions
    contacts
  }

  body
}

/// The base item for resume entries.
/// This formats the item for the resume entries. Typically your body would be a bullet list of items. Could be your responsibilities at a company or your academic achievements in an educational background section.
/// - body (content): The body of the resume entry
#let resume-item(body) = {
  set text(size: 10pt)
  set block(above: 0.5em, below: 1.25em)
  set par(leading: 0.65em)
  block(body)
}

/// The base item for resume entries. This formats the item for the resume entries. Typically your body would be a bullet list of items. Could be your responsibilities at a company or your academic achievements in an educational background section.
/// - title (string): The title of the resume entry
/// - location (string): The location of the resume entry
/// - date (string): The date of the resume entry, this can be a range (e.g. "Jan 2020 - Dec 2020")
/// - description (content): The body of the resume entry
/// - title-link (string): The link to use for the title (can be none)
/// - accent-color (color): Override the accent color of the resume-entry
/// - location-color (color): Override the default color of the "location" for a resume entry.
#let resume-entry(
  title: none,
  location: "",
  date: "",
  description: "",
  title-link: none,
  accent-color: default-accent-color,
  location-color: default-location-color,
) = {
  let title-content
  if type(title-link) == str {
    title-content = link(title-link)[#title #link-icon]
  } else {
    title-content = title
  }
  block(above: 1em, below: 0.65em, {
    if title != none or location != "" {
      justified-header(title-content, location)
    }
    if description != "" or date != "" {
      secondary-justified-header(description, date)
    }
  })
}

/// Show cumulative GPA.
/// *Example:*
/// #example(`resume.resume-gpa("3.5", "4.0")`)
#let resume-gpa(numerator, denominator) = {
  set text(size: 12pt, style: "italic", weight: "light")
  text[Cumulative GPA: #box[#strong[#numerator] / #denominator]]
}

/// Show a certification in the resume.
/// *Example:*
/// #example(`resume.resume-certification("AWS Certified Solutions Architect - Associate", "Jan 2020")`)
/// - certification (content): The certification
/// - date (content): The date the certification was achieved
#let resume-certification(certification, date) = {
  justified-header(certification, date)
}

/// Styling for resume skill categories.
/// - category (string): The category
#let resume-skill-category(category) = {
  set text(hyphenate: false)
  align(left)[
    == #category
  ]
}

/// Styling for resume skill values/items
/// - values (array): The skills to display
#let resume-skill-values(values) = {
  set text(size: 11pt, style: "normal")
  set strong(delta: 100)
  align(
    left,
    // This is a list so join by comma (,)
    values.join(", "),
  )
}

/// Show a list of skills in the resume under a given category.
/// - category (string): The category of the skills
/// - items (list): The list of skills. This can be a list of strings but you can also emphasize certain skills by using the `strong` function.
#let resume-skill-item(category, items) = {
  set block(below: 0.65em)
  set pad(top: 2pt)

  pad(grid(
    columns: (3fr, 8fr),
    gutter: 10pt,
    resume-skill-category(category), resume-skill-values(items),
  ))
}

/// Show a grid of skill lists with each row corresponding to a category of skills, followed by the skills themselves. The dictionary given to this function should have the skill categories as the dictionary keys and the values should be an array of values for the corresponding key.
/// - categories-with-values (dictionary): key value pairs of skill categories and it's corresponding values (skills)
#let resume-skill-grid(categories-with-values) = {
  set block(below: 1.25em)
  set pad(top: 2pt)

  pad(grid(
    columns: (auto, auto),
    gutter: 10pt,
    ..categories-with-values
      .pairs()
      .map(((key, value)) => (
        resume-skill-category(key),
        resume-skill-values(value),
      ))
      .flatten()
  ))
}

/// ---- End of Resume Template ----
