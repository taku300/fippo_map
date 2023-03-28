module FishHelper
  def calculation_tide(date)
    y = date.year
    m = date.month
    d = date.day
    c = 0
    case m
    when 2, 4, 5
      c = 2
    when 6
      c = 4
    when 7
      c = 5
    when 8
      c = 6
    when 9
      c = 7
    when 10
      c = 8
    when 11
      c = 9
    when 12
      c = 10
    end
    age = (((y - 11) % 19) * 11 + c + d) % 30   # 月齢
    case age
    when 1, 2, 14, 15, 16, 17, 29, 30
      "spring"
    when 3, 4, 5, 6, 12, 13, 18, 19, 20, 21, 27, 28
      "middle"
    when 7, 8, 9, 22, 23, 24
      "neap"
    when 10, 25
      "long"
    when 11, 26
      "wakashio"
    end
  end

  def calculation_weather(id)
    case id
    when 200, 201, 202, 210, 211, 212, 221, 230, 231, 232
      'thunderstorm'
    when 300, 301, 302, 310, 311, 312, 313, 314, 321
      'drizzle'
    when 500, 501, 502, 503, 504, 511, 520, 521, 522, 531
      'rain'
    when 600, 601, 602, 611, 612, 613, 615, 616, 620, 621, 622
      'snow'
    when 701, 711, 721, 731, 741, 751, 761, 762, 771, 781
      'fog'
    when 800
      'fine'
    when 801
      'sunny'
    when 802, 803, 804
      'coludy'
    end
  end

  def calculation_wind_direction(deg)
    case deg
    when 0..11.25, 348.75..360
      'north'
    when 11.25..33.75
      'north_northeast'
    when 33.75..56.25
      'northeast'
    when 56.25..78.75
      'east_northeast'
    when 78.75..101.25
      'east'
    when 101.25..123.75
      'east_southeast'
    when 123.75..146.25
      'southeast'
    when 146.25..168.75
      'south_southeast'
    when 168.75..191.25
      'south'
    when 191.25..213.75
      'south_southwest'
    when 213.75..236.25
      'southwest'
    when 236.25..258.75
      'west_southwest'
    when 258.75..281.25
      'west'
    when 281.25..303.75
      'west_northwest'
    when 303.75..326.25
      'northwest'
    when 326.25..348.75
      'north_northwest'
    end
  end

  def weather_request(latitude, longitude)
    client    = HTTPClient.new
    url       = "https://api.openweathermap.org/data/2.5/weather?lat=" + latitude + "&lon=" + longitude + "&appid=" + ENV.fetch('OPEN_WEATHER_API_KEY') + "&lang=ja&units=metric"
    response  = client.get(url)
    JSON.parse(response.body)
  end

  def imput_default(date, latitude, longitude)
    response = weather_request(latitude, longitude)
    weather = calculation_weather(response['weather'][0]['id'])
    wind_direction = calculation_wind_direction(response['wind']['deg'])
    wind_speed = response['wind']['speed']
    temperature = response['main']['temp']
    tide_name = calculation_tide(date)
    default = { fishing_date: date.strftime("%Y-%m-%d %H:%M:%S"),
                latitude:,
                longitude:,
                weather:,
                wind_direction:,
                wind_speed:,
                temperature:,
                tide_name: }
  end
end
