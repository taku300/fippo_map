class FishPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    true
  end

  def show?
    user == record.user || record.user.is_published
  end

  def create?
    true
  end

  def edit?
    user == record.user
  end

  def update?
    user == record.user
  end

  def destroy?
    user == record.user
  end
end
