# encoding: UTF-8
module Bin
  class Store < ActiveSupport::Cache::Store
    attr_reader :collection, :options

    def initialize(collection, options={})
      @collection, @options = collection, options
    end

    def expires_in
      @expires_in ||= options[:expires_in] || 1.year
    end

    def write_entry(key, entry, options={})
      key = key.to_s
      value = entry.value
      expires = Time.now.utc + ((options && options[:expires_in]) || expires_in)
      raw     = !!options[:raw]
      value   = raw ? value : BSON::Binary.new(Marshal.dump(value))
      doc     = {:_id => key, :value => value, :expires_at => expires, :raw => raw}
      collection.save(doc)
    end

    def read_entry(key, options=nil)
      if doc = collection.find_one(:_id => key.to_s, :expires_at => {'$gt' => Time.now.utc})
        value = doc['raw'] ? doc['value'] : Marshal.load(doc['value'].to_s)
        value.is_a?(ActiveSupport::Cache::Entry) ? value : ActiveSupport::Cache::Entry.new(value, options)
      end
    end

    def delete(key, options=nil)
      super do
        collection.remove(:_id => key.to_s)
      end
    end

    def delete_matched(matcher, options=nil)
      collection.remove(:_id => matcher)
    end

    def delete_entry(key, options)
      collection.remove(:_id => key.to_s)
    end

    def exist?(key, options=nil)
      super do
        !read(key, options).nil?
      end
    end

    def increment(key, amount=1)
      counter_key_upsert(key, amount)
    end

    def decrement(key, amount=1)
      counter_key_upsert(key, -amount.abs)
    end

    def clear
      collection.remove
    end

    def stats
      collection.stats
    end

    private
      def counter_key_upsert(key, amount)
        key = key.to_s
        collection.update(
          {:_id => key}, {
            '$inc' => {:value => amount},
            '$set' => {
              :expires_at => Time.now.utc + 1.year,
              :raw        => true
            },
          }, :upsert => true)
      end
  end
end