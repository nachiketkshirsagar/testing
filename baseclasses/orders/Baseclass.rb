class UploadFileClass

  def initialize(options)
    @mer_utility = options[:utility_object]
    @object_config = MerchantUtility::OBJECT_CONFIG
    @config = @mer_utility.config
    @flag = 0
  end
end