class JhunterUserDAO
  include ActiveModel::Model

  #convenience method for access to client in console
  def self.mongo_client
    Mongoid::Clients.default
  end
  #convenience method for access the colelction
  def self.collection
    self.mongo_client[:jhunterusers]
  end
  #all method
  #*prototype - query example
  #*sort - multi-term sort order
  #*offset - start results
  #*limit - number of documents t include
  def self.all(prototype={}, sort={:user=>1}, offset=0, limit=100)
    result = collection.find(prototype).sort(sort).skip(offset)
    result = result.limit(limit) if !limit.nil?
  end
  #find by id
  def self.find(id)
    doc = collection.find(:_id=>id).first
    return doc.nil? ? nil : Zip.new(doc)
  end

  def save
    self.class.collection.insert_one(_id:@id)
  end

  #update
  def update(updates)
  end
  #destroy
  self.clss.collection.find(_id:@id).delete_one

  def persited?
    !@id.nil
  end

  def created_at
    nil
  end

  def updated_at
    nil
  end
end
