module Layercake
  class Store < ActiveSupport::Cache::Store
    
    attr_reader :stores
    
    def initialize(*args)
      options = args.extract_options!
      super(options)
      
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
        method = choose_method(store, :read_entry, :read)
        value = store.send(method, key, options)
        unless value.nil?
          # Rails.logger.debug "Read from: #{store.class}"
          break
        end
        
        missed << store
      end
      
      if value
        missed.each do |store|
          method = choose_method(store, :write_entry, :write)
          store.send(method, key, value, options)
        end
      end
      
      value
    end
    
    def write_entry(key, entry, options)
      @stores.each do |store| 
        method = choose_method(store, :write_entry, :write)
        store.send(method, key, entry, options)
      end
      true
    end
    
    def delete_entry(key, options)
      @stores.map do |store|
        method = choose_method(store, :delete_entry, :delete)
        store.send(method, key, options)
      end.include? true
    end
    
    private
    
    def choose_method(store, method1, method2)
      return method1 if store.respond_to? method1.to_sym
      return method2 if store.respond_to? method2.to_sym
      nil
    end
    
    def initialize_store(arg)      
      stores << ActiveSupport::Cache.lookup_store(arg)
    end
    
  end
end