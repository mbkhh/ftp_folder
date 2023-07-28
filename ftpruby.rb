require 'net/ftp'

CONTENT_SERVER_DOMAIN_NAME = "ee.sharif.edu"
CONTENT_SERVER_FTP_LOGIN = "behrouz.shamsi"
CONTENT_SERVER_FTP_PASSWORD = "sharifee13732"

FOLDER = "new"

# LIST available files at default home directory
#Net::FTP.open(CONTENT_SERVER_DOMAIN_NAME, CONTENT_SERVER_FTP_LOGIN, CONTENT_SERVER_FTP_PASSWORD) do |ftp|
#  files = ftp.list
#
#  puts "list out files in root directory:"
#  puts files
#end

def crawl(file)
	files = Dir[file+"/*"]
	files.each do |file_name|
	  if !File.directory? file_name
	    puts file_name
	    Net::FTP.open(CONTENT_SERVER_DOMAIN_NAME, CONTENT_SERVER_FTP_LOGIN, CONTENT_SERVER_FTP_PASSWORD) do |ftp|
		  ftp.putbinaryfile(File.new(file_name), file_name)
		end
	  else
	  	puts file_name
	  	Net::FTP.open(CONTENT_SERVER_DOMAIN_NAME, CONTENT_SERVER_FTP_LOGIN, CONTENT_SERVER_FTP_PASSWORD) do |ftp|
		  	ftp.mkdir(file_name) if !ftp.list(file).any?{|dir| dir.match(File.basename(file_name))}
		end

	  	crawl(file_name)
	  end
	end
end

crawl(FOLDER)