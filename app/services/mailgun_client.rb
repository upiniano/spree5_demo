require "rest-client"
require "base64"

class MailgunClient
  def self.send_simple_message(to:, subject:, text:, from: nil)
    domain  = ENV["MAILGUN_DOMAIN"]
    api_key = ENV["MAILGUN_API_KEY"]

    from_address = from || "Mailgun Sandbox <postmaster@#{domain}>"

    RestClient.post(
      "https://api.mailgun.net/v3/#{domain}/messages",
      {
        from: from_address,
        to: to,
        subject: subject,
        text: text
      },
      {
        Authorization: "Basic #{Base64.strict_encode64("api:#{api_key}")}"
      }
    )
  end
end
