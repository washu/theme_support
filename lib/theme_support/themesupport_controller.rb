# coding: utf-8
# The controller for serving/cacheing theme content...
#
class ThemesupportController < ActionController::Base

  #after_filter :cache_theme_files
  
  def stylesheets
    render_theme_item(:stylesheets, [params[:filename]].flatten.join('/'), params[:theme])
  end

  def javascript
    render_theme_item(:javascripts, [params[:filename]].flatten.join('/'), params[:theme], 'text/javascript')
  end

  def images
    render_theme_item(:images, [params[:filename]].flatten.join('/'), params[:theme])
  end

  def error
    render :nothing => true, :status => 404
  end
  
  private
  
  def render_theme_item(type, file, theme, mime = mime_for(file))
    render :text => "Not Found", :status => 404 and return if file.split(%r{[\\/]}).include?("..")

    #Call manually, if it is in a after_filter send_file doesn't work
    cache_theme_files

    send_file "#{Themesupport.path_to_theme(theme)}/#{type}/#{file}", :type => mime, :disposition => 'inline'
  end

  def cache_theme_files
    path = request.fullpath
    begin
      ThemesupportController.cache_page( response.body, path )
    rescue
      STERR.puts "Cache Exception: #{$!}"
    end
  end
    
  def mime_for(filename)
    case filename.downcase
    when /\.js$/
      'text/javascript'
    when /\.css$/
      'text/css'
    when /\.gif$/
      'image/gif'
    when /(\.jpg|\.jpeg)$/
      'image/jpeg'
    when /\.png$/
      'image/png'
    when /\.swf$/
      'application/x-shockwave-flash'
    else
      'application/binary'
    end
  end
end


