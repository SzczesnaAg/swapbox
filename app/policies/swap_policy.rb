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
    true
  end

  def choose_item?
    true
  end

  def mark_as_accepted?
    true
  end
end
