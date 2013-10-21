#coding: UTF-8
class Message

  attr_accessor :tel, :extra_info, :name, :serv, :email, :honeypot

  def initialize(args ={})
    @tel        = args[:tel]
    @extra_info = args[:extra_info]
    @name       = args[:name]
    @serv       = args[:serv]
    @email      = args[:email]
    @honeypot   = args[:site]
  end

  def deliver
    return false if spam?
    Pony.mail({
      subject: "#{name} связался с вами",
      body: message_body,
    })
  end

  def spam?
    !honeypot.empty?
  end

  private

  def message_body
    "Телефон: #{tel} \n Услуга: #{serv} \n Email: #{email} \n Дополнительная информация: #{extra_info}"
  end
end
