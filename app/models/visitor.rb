class Visitor < ActiveRecord::Base

  attr_accessor :referer_token

  # Associations below this line
  belongs_to :referer, :class_name => "Visitor", :foreign_key => "referer_id"
  has_many :referrals, :class_name => "Visitor", :foreign_key => "referer_id"

  # validations below this line
  validates_presence_of :email
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

  # method calls below this line
  has_secure_token :refer_token, 6

  # activerecord hooks to be placed below this in order
  before_create :assign_referer
  after_create :sign_up_for_mailing_list

  def assign_referer
    if referer_token.present?
      self.referer_id = Visitor.find_by_refer_token(referer_token).id
    end
  end

  def sign_up_for_mailing_list
    MailingListSignupJob.perform_later(self)
  end

  def subscribe
    mailchimp = Gibbon::API.new(Rails.application.secrets.mailchimp_api_key)
    result = mailchimp.lists.subscribe({
      :id => Rails.application.secrets.mailchimp_list_id,
      :email => {:email => self.email},
      :double_optin => false,
      :update_existing => true,
      :send_welcome => true
    })
    Rails.logger.info("Subscribed #{self.email} to MailChimp") if result
  end

end
