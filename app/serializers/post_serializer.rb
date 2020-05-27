class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :text 
end
