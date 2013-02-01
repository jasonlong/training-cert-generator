require 'prawn'
require 'trollop'

# command line options
opts = Trollop::options do
  banner <<-EOS
This generates a GitHub training certificate in PDF format.

Usage:
       ruby training-cert [options]
where [options] are:
EOS

  opt :recipient, "Recipient's name (required)", :type => String
  opt :company, "Recipient's company name (optional)", :type => String
  opt :course, "Course name (required)", :type => String
  opt :date, "Date (required)", :type => String
  opt :instructor, "Instructor (required)", :type => String
end
Trollop::die :recipient, "must be specified" if !opts[:recipient]
Trollop::die :course, "must be specified" if !opts[:course]
Trollop::die :date, "must be specified" if !opts[:date]
Trollop::die :instructor, "must be specified" if !opts[:instructor]

pdf = Prawn::Document.new(:margin => 1, :page_layout => :landscape)
pdf.font_families.update("Champignon" => {
  :normal => "Champignon.ttf"
})

# background certificate image
pdf.image "certificate.png",
        :position =>  :center,
        :vposition => :center,
        :scale =>     0.23,
        :fit =>       [Prawn::Document::PageGeometry::SIZES["LETTER"][1],
                       Prawn::Document::PageGeometry::SIZES["LETTER"][0]]

# intro
pdf.bounding_box([240, 410], :width => 320, :height => 50) do
  pdf.fill_color "00a5ea"
  pdf.font("Champignon") do
    pdf.text "This certifies that", :size => 32, :align => :center, :valign => :top
  end
end

# recipient name
pdf.bounding_box([240, 367], :width => 320, :height => 30) do
  pdf.fill_color "111111"
  pdf.font("Times-Roman") do
    pdf.text opts[:recipient].upcase, :size => 22, :style => :bold, :align => :center, :valign => :bottom
  end
end

# recipient company name (optional)
unless opts[:company].nil?
  pdf.bounding_box([240, 345], :width => 320, :height => 30) do
    pdf.fill_color "111111"
    pdf.font("Times-Roman") do
      pdf.text opts[:company], :size => 12, :align => :center, :valign => :bottom
    end
  end
end

# requirements blurb
pdf.bounding_box([140, 310], :width => 520, :height => 50) do
  pdf.fill_color "00a5ea"
  pdf.font("Champignon") do
    pdf.text "has completed the training program requirements for", :size => 32, :leading => 3, :align => :center, :valign => :top
  end
end

# course name
pdf.bounding_box([140, 270], :width => 520, :height => 30) do
  pdf.fill_color "111111"
  pdf.font("Times-Roman") do
    pdf.text opts[:course].upcase, :size => 22, :style => :bold, :align => :center, :valign => :bottom
  end
end

# date
pdf.bounding_box([152, 200], :width => 180, :height => 30) do
  pdf.fill_color "111111"
  pdf.font("Times-Roman") do
    pdf.text opts[:date], :size => 12, :valign => :bottom
  end
end

# date label
pdf.bounding_box([152, 182], :width => 180, :height => 30) do
  pdf.fill_color "00a5ea"
  pdf.font("Times-Roman") do
    pdf.text "DATE", :size => 10, :valign => :bottom
  end
end

# instructor
pdf.bounding_box([462, 200], :width => 180, :height => 30) do
  pdf.fill_color "111111"
  pdf.font("Times-Roman") do
    pdf.text opts[:instructor], :size => 12, :valign => :bottom
  end
end

# instructor label
pdf.bounding_box([462, 182], :width => 180, :height => 30) do
  pdf.fill_color "00a5ea"
  pdf.font("Times-Roman") do
    pdf.text "INSTRUCTOR", :size => 10, :valign => :bottom
  end
end

pdf.render_file "#{opts[:recipient]}-#{opts[:course]}.pdf"
