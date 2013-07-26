module UsersHelper


  def object_for(comment)
    obj = Comment.find_commentable(comment.commentable_type, comment.commentable_id)
    obj.name || "#{comment.commentable_type}: #{comment.commentable_id}"
  end

  def path_for_object(comment)
    klass = comment.commentable_type
    obj_id = comment.commentable_id
    send(klass.downcase + '_path', obj_id)
  end
end
