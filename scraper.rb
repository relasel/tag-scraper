require 'nokogiri'
require 'httparty'
require 'byebug'

$url = "https://www.avito.ru"
$unparsed_page =  HTTParty.get($url)
$parsed_page = Nokogiri::HTML($unparsed_page)


def metatitleTest

  metatitle = $parsed_page.css('title').text
  metatitleLength = metatitle.length
  puts ""
  puts "Метатайтл вашей страницы равен #{metatitleLength} знакам"
  puts "Ваш метатайтл выглядит так: #{metatitle}"
  puts ""

end

def metaDescriptionTest

metaDescription =  $parsed_page.at('meta[name="description"]')['content']
metaDescriptionLength = metaDescription.length
  if metaDescription != ""
    puts "Ваш вебсайт содержит мета-описание и его длина равна #{metaDescriptionLength} знакам :"
    puts metaDescription
    puts ""
  else
    puts "Ваш сайт не содержит мета-описания"
    puts ""
  end
end

def metaKeywordsTest
  metaKeywords =  $parsed_page.at('meta[name="keywords"]')['content']
  metaKeywordsLength = metaKeywords.length

    if metaKeywords != ""
      puts "Ваш вебсайт содержит мета-ключевые слова и его длина равна #{metaKeywordsLength} знакам :"
      puts metaKeywords
      puts ""
    else
      puts "Ваш сайт не содержит мета-ключей"
      puts ""
  end
end

def h1h2Test

    h1Tags = $parsed_page.css("h1").text
    h2Tags = $parsed_page.css("h2").text
    if h1Tags !=""
      puts "Ваша странтца содержит х1 тег: #{h1Tags}"
      puts ""
    else
      puts "h1 тегов нет"
      puts ""
  end

    if h2Tags != ""
      puts "h2 Теги:"
      puts h2Tags
      puts ""
    else
      puts "h2 тегов нет"
      puts ""
  end
end

def googlePreviewTest

  puts "Google preview:"
  puts $parsed_page.css('title').text
  puts $url
  puts $parsed_page.at('meta[name="description"]')['content']
  puts ""
end

def robotsTest
  robotsUrl = $url+"/robots.txt"

  parsed_robots_page = Nokogiri::HTML(robotsUrl)
  robots_content = parsed_robots_page.css('body').text

    if robots_content != ""
      puts "Ваш вебсайт содержит robots.txt файл #{robotsUrl}"
      puts ""
    else
      puts "ваш сайт не содержит robots.txt файла"
    end
end




metatitleTest
metaDescriptionTest
metaKeywordsTest
h1h2Test
googlePreviewTest
robotsTest
