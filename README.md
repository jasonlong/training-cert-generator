Command line tool for generating PDF training certificates.

Requirements
============

[Prawn](http://prawn.majesticseacreature.com/) for PDF generation
`gem install prawn`

[Trollop](http://trollop.rubyforge.org/) for command line parsing
`gem install trollop`

Usage
=====
```
       ruby training-cert [options]
where [options] are:
   --recipient, -r <s>:   Recipient's name (required)
     --company, -c <s>:   Recipient's company name (optional)
      --course, -o <s>:   Course name (required)
        --date, -d <s>:   Date (required)
  --instructor, -i <s>:   Instructor (required)
            --help, -h:   Show this message
```

