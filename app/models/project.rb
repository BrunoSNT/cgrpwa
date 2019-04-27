class Project < ApplicationRecord
  belongs_to :client
  accepts_nested_attributes_for :client
  has_many :user_projects
  accepts_nested_attributes_for :user_projects, reject_if: :all_blank, allow_destroy: true
  has_one_attached :avatar

  has_many :users, through: :user_projects
  has_many :payments
  validates :name, presence: true
  validates :description, presence: true
  validates :enddate, presence: true
  validates :price, presence: true

  def self.current_projects
    self.where("enddate > ?", DateTime.now)
  end

  def self.this_year_projects
    self.where("start_date > ?", DateTime.new((DateTime.now.year),1,1))
  end

  def self.faturamento
    total = 0
    self.this_year_projects.each do |project|
      total += project.price
    end

    total
  end

  def self.total_nps
    total = 0
    self.this_year_projects.each do |project|
      if project.nps
        total += project.nps
      else
        total += 1
      end
    end

    total
  end

  def developers
    user_projects.map { |user_project| user_project.user }
  end

  def roles_quantity
    a = user_projects.map { |user_project| user_project.role.name }
    h = Hash.new(0)
    a.each { | v | h.store(v, h[v]+1) }

    h
  end

end
