module Jasminerice
  class SpecController < Jasminerice::ApplicationController
    warn "Using Jasminerice::HelperMethods is deprecated and will be removed in a future release,"\
        "please use Jasminerice::SpecHelper to define your helpers in the future" if defined?(Jasminerice::HelperMethods)

    helper Jasminerice::HelperMethods rescue nil
    helper Jasminerice::SpecHelper rescue nil

    if Rails::VERSION::MAJOR >= 5
      before_action { prepend_view_path Rails.root.to_s }
    else
      before_filter { prepend_view_path Rails.root.to_s }
    end
    layout false

    def index
      @specsuite = params[:suite].try(:concat, "_spec") || "spec"
      @asset_options = %w(true false).include?(params[:debug]) ? { :debug => params[:debug] == 'true' } : {}
    end

    def fixtures
      render "#{Jasminerice.fixture_path}/#{params[:filename]}"
    end
  end
end
