# frozen_string_literal: true

# HomesControllerは、ホームページに関連するアクションを管理するクラス
class HomesController < ApplicationController
  include ApplicationHelper
  def index
    prepare_meta_tags(nil)
  end
end
