module Populate
  class Base
    def initialize(klass, amount = 100)
      @klass = klass
      @amount = amount
    end

    def populate!
      truncate!
      header "Populating #{quantity} #{@klass.to_s.pluralize}"

      quantity.times do
        models << model = @klass.create{|m| populate_attributes(m)}
        status(model)
      end

      puts
      models
    end

    protected

    def populate_attributes(model)
      columns.each do |column|
        model.send("#{column.name}=", data_for_attribute(column))
      end
    end

    def data_for_attribute(column)
      case column.type
      when :boolean
        [true, false].sample
      when :datetime
        case column.name
        when /_at$/
          rand(3.years.ago..Time.now)
        else
          rand(3.years.ago..3.years.from_now)
        end
      when :date
        case column.name
        when /dob|date_of_birth/
          rand(90.years.ago.to_date..13.years.ago.to_date)
        else
          rand(3.years.ago.to_date..3.years.from_now.to_date)
        end
      when :string
        word_count = [*1..10].sample
        str = Faker::Lorem.words(word_count).join(' ')

        case column.name
        when /title|subject/
          str.titleize
        when /first_name/
          Faker::Name.first_name
        when /last_name|surname/
          Faker::Name.last_name
        when /email/
          Faker::Internet.email
        when /url|website/
          Faker::Internet.http_url
        when /user_?name|login|screen_?name/
          Faker::Internet.user_name
        when /phone|mobile/
          Faker::PhoneNumber.phone_number
        when /gender/
          ['male', 'female'].sample
        else
          str
        end
      when :text
        paragraph_count = [*1..4].sample
        Faker::Lorem.paragraphs(paragraph_count).join("\n\n")
      when :integer
        case column.name
        when /_id$/
          reflection_name = column.name[/(.*)_id/, 1].to_sym
          reflection = @klass.reflections[reflection_name]
          active_record = (reflection.options[:class_name] || reflection.name.to_s.classify).constantize
          (cached_ids[reflection_name] ||= active_record.pluck(:id)).sample
        else
          rand(1..999)
        end
      when :float
        case column.name
        when /price|cost/
          ("%.2f" % rand(0.0..500.0)).to_f
        else
          rand(0.0..10.0)
        end
      end
    end

    def cached_ids
      @cached_ids ||= {}
    end

    def columns
      @klass.columns.select do |column|
        !column.name[/^id|updated_at$/]
      end
    end

    def status(model)
      print model.valid? ? '.' : 'F'.color(:red)
    end

    def models
      @models ||= []
    end

    def truncate!
      @klass.delete_all
    end

    def quantity
      @quantity ||= [*@amount].sample
    end

    def header(str)
      puts str.bright.color(:green)
    end
  end
end