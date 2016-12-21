class ContactsController < ApplicationController
  # GET request to /contact-us
  def new
    @contact = Contact.new
  end
  
  # POST request to /contacts
  def create
    # Mass assignment of contact form fields to contact object
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "Message sent."
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      ContactMailer.contact_email(name, email, body).deliver
      redirect_to new_contact_path
    else
      # Flash message with errors in case @contact doesn't save
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  private
    # Whitelisting contact form parameters.
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end