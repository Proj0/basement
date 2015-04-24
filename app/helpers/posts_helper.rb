module PostsHelper
	def action_links
 link_to('编辑', edit_post_path(@post)) + " | " +
 link_to('返回', posts_path)
	end
end
