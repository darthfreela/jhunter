class Empresa
  include Mongoid::Document
  include Mongoid::Timestamps
  attr_accessor :password, :user_name, :cidade, :nome_vaga, :skills_necessarios, :descricao

  #convenience method for access to client in console
  def self.mongo_client
    Mongoid::Clients.default
  end
  #convenience method for access the colelction
  def self.collection
    self.mongo_client[:jhuntercompanyes]
  end

  def save(e)
    SymmetricEncryption.load!
    pass = SymmetricEncryption.encrypt e.password
    self.class.collection.insert_one(user_name: e.user_name,
                                      password: pass,
                                      cidade: e.cidade)
  end

  def self.inserir_nova_vaga(params)
    collection.updateOne( {_id: BSON::ObjectId(session['$oid'])},
                            {$set: {vagas :
                              [
                                {nome_vaga: params.nome_vaga},
                                {skills_necessarios: params.skills_necessarios},
                                {descricao: params.descricao}
                              ]
                            }
                          })

    return true
  end

  def self.return_empresa_data(session)
    doc = collection.find(_id: BSON::ObjectId(session['$oid'])).first
    return doc.nil? ? nil : Empresa.new(doc)
  end

  def self.find(session, pass)
    SymmetricEncryption.load!
    pass = SymmetricEncryption.encrypt pass
    doc = collection.find(user_name: session, password: pass).first
    return doc.nil? ? nil : Empresa.new(doc)
  end

  def self.find_session(session)
    doc = collection.find(_id: BSON::ObjectId(session['$oid'])).first
    return doc.nil? ? nil : Empresa.new(doc)
  end

end
