class HomeController < ApplicationController
  def index
    @events = Event.limit(20)
  end

  def fetch_events
    a = Time.now
    upsert
    @time = Time.now - a
    puts "Completed in #{(Time.mktime(0)+@time).strftime("%H:%M:%S")} seconds"
  end

  def clear_events
    a = Time.now
    Event.delete_all
    @time = Time.now - a
    puts "Completed in #{(Time.mktime(0)+@time).strftime("%H:%M:%S")} seconds"
    redirect_to root_url
  end

  private
    def used
      puts Event.create(api_responses)
    end

    def import
      events = []
      api_responses.each do |event|
        events << Event.new(event)
      end
      puts Event.import events
    end

    def vanilla
      values = api_responses.map {|e| "('#{e[:event_id]}', '#{e[:name]}', '#{e[:description]}', #{e[:price]}, NOW(), NOW())"}
      sql = "INSERT INTO events (event_id, name, description, price, created_at, updated_at) VALUES #{values.join(', ')}"
      puts ActiveRecord::Base.connection.execute(sql)
    end

    def upsert
      conn = Mysql2::Client.new(host: "localhost", username: "root", database: "hariinigajian_dev")
      Upsert.batch(conn, :events) do |upsert|
        api_responses.each do |event|
          upsert.row(
            {
              event_id: event[:event_id]
            },
            name: event[:name],
            description: event[:description],
            price: event[:price],
            created_at: DateTime.now,
            updated_at: DateTime.now
            )
        end
      end
    end

    def api_responses(data = 1000)
      auto_responses(data)
    end

    def auto_responses(data)
      data.times.map do |i|
        {
          event_id: "EVT#{i}",
          name: "Event Name #{i}",
          description: "Description #{i}",
          price: 1000*i
        }
      end
    end

    def custom_responses
      [
        {
          event_id: 'EVT0',
          name: 'Test Event Custom',
          description: 'ini deskripsi',
          price: 15000
        },
        {
          event_id: 'EVT2',
          name: 'Weekly Team',
          description: 'Weekly adalah itu...',
          price: 20000
        },

      ]
    end
end
