WickedPdf.config = {
  #:wkhtmltopdf => '/usr/local/bin/wkhtmltopdf',
  :layout => "pdf.html",
  :margin => {
                  :top  => 5,
                  :bottom => 5,
                  :left => 5,
                  :right => 5
               },
  :zoom => 1,
  :exe_path => ((Config::CONFIG['host_os'] =~ /mswin|mingw/).nil?) ? '/usr/local/bin/wkhtmltopdf' : 'D:/wkhtmltopdf/wkhtmltopdf.exe'
}
