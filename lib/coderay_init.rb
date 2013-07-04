module CoderayInitializer
  def self.registered(app)
    app.use Rack::Coderay, "//pre[@lang]", :line_numbers => :table

  end
end
