require 'nokogiri'
require 'httparty'
require 'byebug'
require 'open-uri'

$url = "https://www.ebay.com"
$unparsed_page =  HTTParty.get($url)
$parsed_page = Nokogiri::HTML($unparsed_page)


def metatitleTest

  metatitle = $parsed_page.css('title').text.strip
  metatitleLength = metatitle.length
  puts ""
  puts "Метатайтл вашей страницы равен #{metatitleLength} знакам"
  puts "Ваш метатайтл выглядит так: #{metatitle}"
  puts ""

end

def metaDescriptionTest

metaDescription = $parsed_page.search("meta[name='description']").map {|n| n['content']}[0]

if metaDescription != nil
    metaDescriptionLength = metaDescription.length
    puts "Ваш вебсайт содержит мета-описание и его длина равна #{metaDescriptionLength} знакам :"
    puts metaDescription
    puts ""
  else
    puts "Ваш сайт не содержит мета-описания"
    puts ""
  end

end

def metaKeywordsTest
  metaKeywords =  $parsed_page.search("meta[name='keywords']").map {|n| n['content']}[0]
  if metaKeywords != nil && metaKeywords != ""
      metaKeywordsLength = metaKeywords.length
      puts "Ваш вебсайт содержит мета-ключевые слова и его длина равна #{metaKeywordsLength} знакам :"
      puts metaKeywords
      puts ""
    else
      puts "Ваш сайт не содержит мета-ключей"
      puts ""
  end

end

def h1h2Test

    h1Tags = $parsed_page.css("h1").text.strip
    h2Tags = $parsed_page.css("h2").text.strip
    if h1Tags !=""


      puts "Ваша странтца содержит х1 тег: #{h1Tags}"
      puts ""

    else
      puts "h1 тегов нет"
      puts ""

  end

    if h2Tags != ""
      puts "всего #{$parsed_page.css("h2").count} тегов"

    $parsed_page.css("h2").each do |n|
    #    if n!=nil && n.text!=""
            puts n.text.strip
            puts ""
    #    end
    end
    else
      puts "h2 тегов нет"
      puts ""
  end
end

def linksTest
  links = $parsed_page.css('a')
  puts ""
  puts "your page contains #{links.count} links:"
    links.each do |l|
      puts l[:href]
  end
  puts ""

end

def googlePreviewTest

  puts "Google preview:"
  puts $parsed_page.css('title').text.strip
  puts $url
  if $parsed_page.search("meta[name='description']").map {|n| n['content']}[0] != nil
  puts $parsed_page.search("meta[name='description']").map {|n| n['content']}[0]
end
  puts ""
end

def robotsTest
  robotsUrl = $url+"/robots.txt"

  parsed_robots_page = Nokogiri::HTML(robotsUrl)
  robots_content = parsed_robots_page.css('body')

    if robots_content != ""
      puts "Ваш вебсайт содержит robots.txt файл #{robotsUrl}"
    #  puts robots_content
      puts ""
    else
      puts "ваш сайт не содержит robots.txt файла"
    end

end

def  styleTest
  style = $parsed_page.css('style')
  counter = 1
  if style.count != 0
    puts "Ваша страница содержит #{style.count} inline стилей"
    puts ""
    style.each do |s|
      puts counter
      puts s.text
      counter= counter+1
    end

  else
    puts "ваша страница не содержит inline стилей "
    puts ""
  end
end




metatitleTest
metaDescriptionTest
metaKeywordsTest
h1h2Test
linksTest
googlePreviewTest
robotsTest
styleTest
