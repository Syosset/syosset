require 'net/https'
require 'uri'
require 'json'

module Azure
  class CognitiveServices
    def self.alt_description(image_url)
      if (desc = $redis.get(redis_key = "azure:cognitive_services:#{image_url}:alt_description")).nil?
        region = ENV['AZURE_REGION'] || 'eastus'
        key = ENV['AZURE_COGNITIVE_SERVICES_KEY']
        return nil if key.nil?

        uri = URI("https://#{region}.api.cognitive.microsoft.com/vision/v1.0/describe")

        request = Net::HTTP::Post.new(uri.request_uri)
        request['Content-Type'] = 'application/json'
        request['Ocp-Apim-Subscription-Key'] = key
        request.body = { url: image_url }.to_json

        response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(request)
        end

        desc = if response.is_a? Net::HTTPSuccess
                 JSON.parse(response.body)['description']['captions'][0]['text']
               else
                 'Unlabeled image'
               end

        $redis.set(redis_key, desc)
        $redis.expire(redis_key, 12.hours)
      end

      desc
    end
  end
end
