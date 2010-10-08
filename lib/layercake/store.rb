module Layercake
  class Store < ActiveSupport::Cache::Store
    
    attr_reader :stores
    
    def initialize(*args)
      super()
      @stores = []
      
      args.each do |arg|
        initialize_store(arg)
      end
    end
    
    
    def clear(options = nil)
      @stores.each{|store| store.clear(options) }
    end
    
    def cleanup(options = nil)
      @stores.each{|store| store.cleanup(options)}
    end
    
    def increment(name, amount = 1, options = nil)
      @stores.map{|store| store.increment(name, amount, options)}.first
    end
    
    def decrement(name, amount = 1, options = nil)
      @stores.map{|store| store.decrement(name, amount, options)}.first
    end
    
    def delete_matched(matcher, options = nil)
      @stores.each{|store| store.delete_matched(matcher, options)}
    end
    
    
    protected
    def read_entry(key, options)
      value = nil
      missed = []
      
      @stores.each do |store|
        value = store.send(:read_entry, key, options)
        unless value.nil?
          # Rails.logger.debug "Read from: #{store.class}"
          break
        end
        
        missed << store
      end
      
      if value
        missed.each do |store|
          store.send(:write_entry, key, value, options)
        end
      end
      
      value
    end
    
    def write_entry(key, entry, options)
      @stores.each{|store| store.send(:write_entry, key, entry, options) }
      true
    end
    
    def delete_entry(key, options)
      @stores.map do |store|
        store.send(:delete_entry, key, options)
      end.include? true
    end
    
    private
    def initialize_store(arg)
      parameters = arg
      *parameters = *[arg.keys.first, arg.values].flatten if arg.is_a?(Hash)
      
      stores << ActiveSupport::Cache.lookup_store(parameters)
    end
    
  end
end