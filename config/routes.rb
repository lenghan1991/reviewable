GitlabReviewable::Engine.routes.draw do
	get 'diffs' => 'reviews#diffs'
	get 'discussion' => 'reviews#discussion'
	get 'help/shortcuts'
end
