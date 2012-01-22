class GeneralController < ApplicationController
  #before_filter :login_required, :except => []
  #before_filter :login_required, :except => [:user_list_new_or_old_info, :mail_to_friend_form, :mail_to_friend, :mail_private, :user_list_like_dislike, :show_comment, :user_vote]
  #before_filter :activated_required, :except =>[:user_list_new_or_old_info, :mail_to_friend_form, :mail_to_friend, :mail_private, :user_list_like_dislike, :show_comment, :user_vote, :create_photo, :update_photo]
  #protect_from_forgery :except => [:create_photo, :update_photo]
  
  def restricted_access
    
  end
 
  def mail_private
    if params[:model] == "DBlog"
      object = DBlog.find(params[:id])
      header = "Send #{object.title} to your friends."
    elsif params[:model] == "DStuff"
      object = DStuff.find(params[:id])
      header = "Send #{object.name} to your friends."
    elsif params[:model] == "DBrand"
      object = DBrand.find(params[:id])
      header = "Send mail to #{object.name}."
      to = object.name
      to_email = object.email
    elsif params[:model] == "DUserDetail"
      object = DUserDetail.find(params[:id])
      header = "Send mail to #{object.user.full_name}."
      to = object.user.full_name
      to_email = object.user.email
    end

    respond_to do |format|
      if request.xhr?
        format.js do
          render :update do |page|
            if logged_in?
              page.replace_html 'popup_box_content', :partial => "general/mail_private", :locals => {:model => params[:model], :id => object.id, :to =>to, :to_email => to_email}
            else
              #session[:return_to] = request.url => should set on the request form
              page.replace_html 'popup_box_content', :partial => "/sessions/form"
            end
            page['popup_box_header'].innerHTML = header
          end
        end
      else
        if logged_in?
          format.html { render :partial => "general/mail_private", :locals => {:model => params[:model], :id => object.id, :to =>to, :to_email => to_email}, :layout => session[:layout] }
        else
          #session[:return_to] = request.request_uri => should set on the request form
          format.html { render :partial => "/sessions/form", :layout => session[:layout] }
        end
      end
    end
  end

  def mail_to_friend_form
    if params[:model] == "DBlog"
      object = DBlog.find(params[:id])
      header = "Send #{object.title} to your friends."
    elsif params[:model] == "DStuff"
      object = DStuff.find(params[:id])
      header = "Send #{object.name} to your friends."
    elsif params[:model] == "DBrand"
      object = DBrand.find(params[:id])
      header = "Send mail to #{object.name}."
    elsif params[:model] == "DCoolStatus"
      object = DCoolStatus.find(params[:id])
      header = "Tell Your Friend To Vote Your Cool Status"
    end

    respond_to do |format|
      if request.xhr?
        format.js do
          render :update do |page|
            page.replace_html 'popup_box_content', :partial => "general/mail_to_friend", :locals => {:model => params[:model], :object => object}
            page['popup_box_header'].innerHTML = header
          end
        end
      else

      end
    end
  end

  def mail_to_friend
    mail_to = params[:mail][:to]
    temps = Array.new
    if mail_to.include? ";"
      temps = mail_to.split(";")
      new_adr = ""
      temps.each do |temp|
        new_adr = temp.strip+","+new_adr
      end

      mail_to = new_adr[0..new_adr.length-2]
    end
    puts mail_to
    msg = params[:mail][:msg]
    if (logged_in? rescue false)
        user = current_user
    else
        user = params[:mail][:from]
    end

    if params[:model] == "DBlog"
      object = DBlog.find(params[:id])
      respon = "#{object.title} has been sent."
      ll_blog_tags = LlBlogTag.find_all_by_idblog(object.id)
      array_tag = Array.new
      ll_blog_tags.each do |ll_blog_tag|
        array_tag << ll_blog_tag.l_tag
      end
      
      UserMailer.article_email(object, mail_to, msg, array_tag, user).deliver rescue (respon = false)
    elsif params[:model] == "DStuff"
      object = DStuff.find(params[:id])
      respon = "#{object.name} has been sent."
      ll_tags = LlStuffTag.find_all_by_idstuff(object.id)
      array_tag = Array.new
      ll_tags.each do |ll_tag|
        array_tag << ll_tag.l_tag
      end
      if (logged_in? rescue false)
        user = current_user
      else
        user = params[:mail][:from]
      end
      UserMailer.stuff_email(object, mail_to, msg, array_tag, user).deliver rescue (respon = false)
    elsif params[:model] == "DBrand"
      respon = "Message has been sent."
      UserMailer.pm_email(mail_to, msg, user).deliver rescue (respon = false)
     elsif params[:model] == "DUserDetail"
      respon = "Message has been sent."
      UserMailer.pm_email(mail_to, msg, user).deliver rescue (respon = false)
    elsif params[:model] == "DCoolStatus"
      object = DCoolStatus.find(params[:id])
      respon = "Message has been sent."
      UserMailer.cool_status_email(mail_to, msg, user, object).deliver rescue (respon = false)
    end

    respond_to do |format|
      if request.xhr?
        format.js do
          render :update do |page|
            if respon == false
              page['popup_box_content_error_message'].innerHTML = "Something went wrong. Message has not been send"
              page['popup_box_content_error_message'].show()
            else
              page['popup_box_content_error_message'].hide()
              page.replace_html 'popup_box_content', respon
              page << ""
            end
          end
        end
      else
        if respon == false
          respon = "Something went wrong. Message has not been send"
        end
        format.html { redirect_to session[:return_to], :notice => respon }
      end
    end
  end

  def create_photo(direct_update=false)
    
    param_id = params[:param_id]
    param_name = params[:param_name]
    model = params[:model].camelize.constantize 

    if params[:Filedata]
      object_photo = model.new( :image => params[:Filedata] )
    else
      object_photo = model.new(params[:object])
    end

    object_photo.attributes = {"#{param_name}" => param_id}
    div_id = param_id

    if params[:div_target]
      div_target = params[:div_target]
    else
      div_target = "new_photo"
    end

    error_msg = ""
    respond_to do |format|    
          if object_photo.save
          else
            object_photo.errors.each do|attr,msg|
                error_msg = "#{attr}:#{msg}\n" + error_msg
              end
          end
        format.js do
          #responds_to_parent do
            render :update do |page|
              if error_msg != ""
                page.alert(error_msg)
              end
              if direct_update
                page.replace "photo_#{div_id}", :partial => "general/photos_edit",
                                               :locals => {:controller => "general",
                                                           :model => model,
                                                           :object_photo => object_photo,
                                                           :param_id => param_id,
                                                           :photo_title => (object_photo.caption rescue ""),
                                                           :height => (params[:height] rescue 100), :width => (params[:width] rescue 100),
                                                           :show_none_image =>params[:show_none_image],
                                                           :editing_mode => true
                                                          }
                page.visual_effect :highlight, "photo_#{div_id}"
              else
                page.insert_html :before, div_target,
                                          :partial => "general/photo_manage",
                                                      :locals => {:controller => "general",
                                                                  :model => model,
                                                                  #:iduser => iduser,
                                                                  :object_photo => object_photo,
                                                                  :param_id => param_id,
                                                                  :photo_title => (object_photo.caption rescue ""),
                                                                  :group => (params[:group] rescue 'new_image'),
                                                                  :height => (params[:height] rescue 100), :width => (params[:width] rescue 100),
                                                                  :show_none_image =>params[:show_none_image],
                                                                  :use_cover => (params[:use_cover] rescue false),
                                                                  :editing_mode => true
                                                                  }
                page.visual_effect :highlight, "photo_#{object_photo.id}"
              end
                #page << "SexyLightbox.refresh();"
            end
        end
    end
  end

  def update_photo
    
    error = false
    error_msg = ""
    param_id = params[:param_id]
    model = params[:model]

    object_photo = model.where("idalbum = ?", param_id) rescue nil
    photo_title = object_photo.caption rescue ''

    if object_photo.nil?
      create_photo(true)
      return
    end
    if params[:Filedata]
      #params[:Filedata].content_type = MIME::Types.type_for(params[:Filename])
      unless object_photo.update_attributes( :image => params[:Filedata] )
        error = true
      end
    else
      unless object_photo.update_attributes(params[:object])
        error = true
      end
    end

    if error
      object_photo.errors.each do|attr,msg|
        error_msg = "#{attr}:#{msg}\n" + error_msg
      end
    end
      
    respond_to do |format|
        format.html
        format.js do
            render :update do |page|
              if error
                page.alert(error_msg)
              end
                page.replace "photo_#{param_id}", :partial => "general/photos_edit",
                                                      :locals => {:controller => "general",
                                                                  :model => params[:model],
                                                                  #iduser => iduser,
                                                                  :object_photo => object_photo,
                                                                  :param_id => param_id,
                                                                  :photo_title => (photo_title rescue ""),
                                                                  :height => (params[:height] rescue 100), :width => (params[:width] rescue 100),
                                                                  :show_none_image =>params[:show_none_image],
                                                                  :editing_mode => true
                                                      }
                page.visual_effect :highlight, "photo_#{param_id}"
                page << "SexyLightbox.refresh();"
            end
        end
    end
  end

  def update_photo_caption
    model = params[:model].camelize.constantize
    object = model.find(params[:id])
    object.caption = params[:caption]

    object.save

    respond_to do |format|
      format.js {
          render :update do |page|
            page.replace "caption#{params[:id]}", :partial => "general/photo_caption", :locals => {:object_photo => object}
            #page['caption'+params[:id]].innerHTML = (object.caption.length > 20 ? object.caption[0..20]+"..." : object.caption) rescue ""
            #page['caption'+params[:id]].highlight()
            page['edit_caption'+params[:id]].hide()
          end
      }
    end
  end

  def select_thumbnail_cover
    model = params[:model].camelize.constantize
    id = params[:id]
    param_id = params[:param_id]
    objects = model.find_all_by_idalbum(param_id)
    
    objects.each do |object|
      if object.id == id.to_i
        object.is_cover = true
        object.save
      else
        if object.is_cover
          object.is_cover = false
          object.save
        end
      end
    end

    render :nothing => true
  end

  def update_image_order
    model = params[:model].camelize.constantize
    list = params[:data].split('&')

    i = 0
    list.each do |data|
      temp = data.split("#{params[:model]}_#{params[:id]}[]=")
      id = temp[1]
      
      object = model.find(id)
      object.image_order = i
      object.save
      i+=1
    end

    render :text => "success sorting image"
  end

  def delete_photo
    model = params[:model].camelize.constantize
    param_id = params[:param_id]
    iduser = params[:iduser]
    
    object_photo = model.find(params[:id])
    object_photo.destroy
    div_id = param_id

    respond_to do |format|
      if request.xhr?
        format.js do
          render :update do |page|
            if (params[:render_upload_form] rescue false)
              page.replace "photo_#{div_id}", :partial => "general/photos_edit",
                                                        :locals => {:controller => "general",
                                                                    :model => params[:model],
                                                                    #:iduser => iduser,
                                                                    :object_photo => nil,
                                                                    :param_id => param_id,
                                                                    :photo_title =>  "",
                                                                    :show_none_image =>params[:show_none_image]
                                                        }
                page.visual_effect :highlight, "photo_#{param_id}"
                page << "SexyLightbox.refresh();"
            else
              #page.replace "photo#{params[:id]}", ""
              page['photo_'+params[:id].to_s].fade()
            end
          end
         end
      else
        format.html { redirect_to(request.fullpath) }
        format.xml  { head :ok }
      end
    end
  end

  def upload_photo_from_ckeditor
    param_id = params[:param_id]
    iduser = params[:iduser]

    if params[:model] == "ArticleGallery"
      album_gallery = AlbumGallery.find_by_name_and_iduser("Article Image",iduser)
      if album_gallery.nil?
        album_gallery = AlbumGallery.new
        album_gallery.name = "Article Image"
        album_gallery.iduser = iduser
        album_gallery.is_active = false
        album_gallery.save
      end
      object_photo = Gallery.new(:image => params[:upload])
      object_photo.iduser = iduser
      object_photo.idalbum = album_gallery.id
    elsif params[:model] == "DMainPhotoArticle"
      object_photo = DMainPhotoArticle.new(:image => params[:upload])
      object_photo.iduser = iduser
    end


    error_msg = ""
    #respond_to do |format|
          #if params[:upload]
            #params[:upload].content_type = MIME::Types.type_for(params[:upload])
            #object_photo = DGalery.new( :image => params[:upload] )
          #else

          #end

          if object_photo.save
            #callback = "alert('Success')"
            callback = params[:CKEditorFuncNum]
            url = object_photo.image_url()
            msg = "success"
          else
            object_photo.errors.each do|attr,msg|
                error_msg = "#{attr}:#{msg}\n" + error_msg
              end
              callback = params[:CKEditorFuncNum]
              url = ""
              msg = "Fail, "+error_msg
          end

  output = '<html><body><script type="text/javascript">window.parent.CKEDITOR.tools.callFunction('+callback+', "'+url+'","'+msg+'");</script></body></html>';
  output_js = 'window.parent.CKEDITOR.tools.callFunction('+callback+', "'+url+'","'+msg+'");';
  render :text => output
  end

  def show_article_photo
    param_id = params[:param_id]
    iduser = params[:iduser]
    @funcNum = params[:CKEditorFuncNum]
    if params[:model] == "DAlbumGallery"
    elsif params[:model] == "DMainPhotoArticle"
      @object_photo = DMainPhotoArticle.find_all_by_parent_id(nil)
    elsif params[:model] == "DBrandPhotoArticle"
      @object_photo = DBrandPhotoArticle.find_all_by_idbrand(param_id)
    end
    

    respond_to do |format|
      if request.xhr?
        format.html {render :layout => false}
      else
        if @funcNum.nil?
           format.html # index.html.erb
        else
          format.html {render :layout => false}# index.html.erb
        end

        format.xml  { render :xml => @object_photo }
      end
    end

  end

end
