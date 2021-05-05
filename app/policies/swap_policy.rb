class SwapPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def destroy?
    user == record.user
  end

  def show?
    user == record.user || record.product.user = user
  end

  def mark_as_rejected?
    user == record.user || record.product.user = user
  end

  def choose_item?
    user == record.user || record.product.user = user
  end

  def mark_as_accepted?
    user == record.user || record.product.user = user
  end

  def mark_as_exchanged?
    user == record.user || record.product.user = user
  end

  def mark_as_canceled?
    user == record.user
  end

  def info?
    true
  end

  def mark_as_read?
    true
  end

  def mark_messages_as_read?
    true
  end
end
