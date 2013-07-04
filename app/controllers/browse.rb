FsApp.controllers :browse do
  get :index, :map => '/*splat' do
    ap params
    @parent_path = params[:splat][1..-2].join('/')
    @current_path = params[:splat][1..-1].join('/')

    ap @parent_path
    ap @current_path

    @path = Pathname("/#@current_path")

    if @path.directory?
      @current_path += '/' if @current_path.present?

      @current_path = URI::encode(@current_path)
      ap @current_path

      @files = Pathname.glob("#@path/*").sort do |file1, file2|
        if file1.directory? && !file2.directory?
          -1
        elsif !file1.directory? && file2.directory?
          1
        else
          file1 <=> file2
        end
      end

      ap @files
      render 'browse/index'
    else
      file = @path

      if file.extname == '.rb'
        @code = CodeRay.scan(File.read(file), :ruby).html
        render 'browse/code'
      else
        mimetype = `file -b --mime-type "#{file}"`.gsub(/\n/,"")
        puts "serving #{file} with mimetype #{mimetype}"
        send_file file, :stream => true, :type => mimetype, :disposition => :inline
      end
    end
  end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   session[:foo] = "bar"
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  
end
