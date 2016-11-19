require "./secret.rb"
require "oauth"
require 'rest-client'
require 'json'
require 'addressable/uri'
require 'launchy'
require 'YAML'


class Client
  CONSUMER = OAuth::Consumer.new(
    TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET, :site => "http://twitter.com")

  def request_access_token
    request_token = CONSUMER.get_request_token
    Launchy.open(request_token.authorize_url)

    puts "Login, and type your verification code in"
    oauth_verifier = gets.chomp

    access_token = request_token.get_access_token(
      :oauth_verifier => oauth_verifier)
  end

  def go_loop(token)
    while true
      puts "What would you like to do?"
      puts "A.  Tweet"
      puts "B.  View your Tweets"
      puts "C.  View another User's Tweets"
      puts "D.  DM somebody."
      puts "E.  Exit"
      puts "Select letter of what you would like to do:"
      selection = gets.chomp.upcase

      case selection
        when "A"
          post_tweet(token)
        when "B"
          print_user_timeline(token)
        when "C"
          get_others_timeline(token)
        when "D"
          dm(token)
        when "E"
          Kernel::exit
      end
    end

  end

  def post_tweet(access_token)
    posted = false
    until posted
      puts "Write your tweet: "
      status = gets.chomp
      if status.length > 140
        puts "Tweet too long! #{post.length}/140 Characters"
        next
      else
        status = {:status => status}
        access_token.post("https://api.twitter.com/1.1/statuses/update.json", status)
        posted = true
        puts "POST MADE!"
      end
    end

  end

  def user_timeline(access_token)
    response = access_token.get("http://api.twitter.com/1.1/statuses/user_timeline.json").body
    parsed_response = JSON.parse(response)

    parsed_response
  end

  def print_user_timeline(access_token)
    parsed_response = user_timeline(access_token)

    parsed_response.each do |tweet|
      print "Created On: #{tweet["created_at"]}\t Text: #{tweet["text"]}\n"
    end
  end

  def get_others_timeline(access_token)
    puts "Who's status do you want to get?"
    screen_name = gets.chomp
    request = Addressable::URI.new(
      :scheme => "https",
      :host => "api.twitter.com",
      :path => "1.1/statuses/user_timeline.json",
      :query_values => {
        :screen_name => screen_name
      }
    )

    response = access_token.get(request.to_s).body

    parsed_response = JSON.parse(response)
    parsed_response.each do |tweet|
      print "Created On: #{tweet["created_at"]}\t Text: #{tweet["text"]}\n"
    end
  end

  def dm(access_token)

    puts "Write your text: "
      text = gets.chomp
    puts "Who do you want to send it to?"
      screen_name = gets.chomp

    access_token.post("https://api.twitter.com/1.1/direct_messages/new.json", :text => text, :screen_name => screen_name)
    puts "DM SENT!"

  end

  def get_token(token_file)
    if File.exist?(token_file)
      File.open(token_file) { |f| YAML.load(f) }
    else
      access_token = request_access_token
      File.open(token_file, "w") { |f| YAML.dump(access_token, f) }

      access_token
    end
  end

end

# Test suite
 g = Client.new()
 token = g.get_token("access_token.yaml")
 g.go_loop(token)