#import "lib.typ": *

#show: resume.with(
  author: (
    firstname: "João",
    lastname: "Pereira",
    email: "me@toino.pt",
    website: "https://toino.pt",
    github: "ttoino",
    birth: "August 21, 2002",
    linkedin: "joão-pereira-543b26217",
    positions: (),
    address: "Porto, Portugal",
  ),
  language: "en",
  colored-headers: true,
  show-footer: false,
  paper-size: "a4",
)

= Experience

#resume-entry(
  title: "Investigation Grant Recipient / Junior Scientist",
  location: "Porto, Portugal",
  date: "August 2023 - August 2024",
  description: "Fraunhofer Portugal AICOS",
)

#resume-item[
  - Deployed a mobile application for patient monitoring using Flutter and Fhir
  - Investigated obfuscation techniques for machine learning models on mobile devices
  - Collaborated with a team of researchers in the development of a trial management system
]

#resume-entry(
  title: "Compilers Class Assistant",
  location: "Porto, Portugal",
  date: "February - June 2024",
  description: "Faculty of Engineering of the University of Porto",
)

#resume-item[
  - Provided support to students during practical classes and office hours
  - Collaborated with professors to improve course materials and assignments
]

= Projects

#resume-entry(
  title: "Mopidy Marceline",
  location: github-link("ttoino/mopidy-marceline")[],
  date: "March 2025 - Present",
  description: "Svelte, Tailwind, Typescript, Python",
)

#resume-item[
  - Designed and implemented a stylish frontend for Mopidy, a music server written in Python
  - Built using Svelte M3C, my own component library for Svelte based on Material design
  - Implemented a CI/CD pipeline using GitHub Actions to automate testing and deployment
]

#resume-entry(
  title: "Personal Website",
  title-link: "https://toino.pt",
  location: github-link("ttoino/website")[],
  date: "July 2023 - Present",
  description: "Svelte, Tailwind, Typescript",
)

#resume-item[
  - Designed and developed my personal website to showcase my personal projects
  - Built using Svelte and Tailwind CSS for a modern and responsive design
  - Implemented a CI/CD pipeline using GitHub Actions to automate testing and deployment
]

#resume-entry(
  title: "Self-Hosting Infrastructure",
  location: github-link("ttoino/hosting")[],
  date: "June 2023 - Present",
  description: "Docker, Caddy, Linux",
)

#resume-item[
  - Designed a self-hosting infrastructure to host my personal website and projects
  - Deployed using Docker Compose for containerization, and Caddy as a reverse proxy with automatic HTTPS
  - Integrated several personal projects through CD pipelines using GitHub Actions
]

#resume-entry(
  title: "Meterial Symbols",
  title-link: "https://meterial.toino.pt",
  location: github-link("ttoino/meterial-symbols")[],
  date: "August 2025 - September 2025",
  description: "Python",
)

#resume-item[
  - Created a variable font based on Google's Material Symbols, with support for a custom progress axis
  - Developed a Python script to generate the variable font from individual SVG icons
]

= Education

#resume-entry(
  title: "Faculty of Engineering of the University of Porto",
  location: "Porto, Portugal",
  date: "2023 - Present",
  description: "Master's in Informatics and Computing Engineering",
)

#resume-item[
  - Currently maintaining a grade of 17/20
  - Participated in an exchange semester at the University of Leiden in the Netherlands
  - Relevant coursework: Mobile Application Development
]

#resume-entry(
  date: "2020 - 2023",
  description: "Bachelor's in Informatics and Computing Engineering",
)

#resume-item[
  - Graduated with a final grade of 18/20
  - Relevant coursework: Data Structures and Algorithms, Databases, Web Development, Software Engineering
]

= Skills

#resume-skill-grid((
  "Spoken Languages": (
    [*Portuguese*],
    [*English*],
    text(weight: "light")[Spanish],
  ),
  "Programming Languages": (
    [Typescript/Javascript],
    [Python],
    [Dart],
    [Java],
    [C/C++],
    [Haskell],
  ),
  "Technologies": (
    [Svelte],
    [React],
    [Flutter],
    [Docker],
    [Git],
    [Linux],
    [Github Actions],
  ),
))
