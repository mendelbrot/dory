# defmodule DoryWeb.ForumLive do
#   use DoryWeb, :live_view

#   def mount(params, _session, socket) do
#     _forum_id = params["forum_id"]

#     # get forum name
#     # get list of forum posts

#     forum_name = "Home"

#     posts = [
#       %{
#         id: "123",
#         user_id: "234",
#         forum_id: "999",
#         username: "abc",
#         user_icon: "/images/user_icons/123.png",
#         created_at: "2022-08-11 21:06:17+03",
#         updated_at: "2022-08-11 21:06:17+03",
#         ref_post_id: "123",
#         post_to_main_feed: true,
#         body: "hello 👋 this is a post 😃"
#       },
#       %{
#         id: "545",
#         user_id: "1",
#         forum_id: "999",
#         username: "cba",
#         created_at: "2023-08-12 21:06:17+03",
#         updated_at: "2023-08-12 21:06:17+03",
#         ref_post_id: "123",
#         post_to_main_feed: true,
#         body: "🌠🚀 and 👾"
#       },
#       %{
#         id: "543",
#         user_id: "1",
#         forum_id: "999",
#         username: "cba",
#         created_at: "2023-08-11 21:06:17+03",
#         updated_at: "2023-08-11 21:06:17+03",
#         ref_post_id: "123",
#         post_to_main_feed: false,
#         body: "hi there.  this is neat. 💚"
#       }
#     ]

#     main_feed =
#       posts
#       |> Enum.filter(fn p -> p.post_to_main_feed == true end)
#       |> Enum.sort(fn p1, p2 -> p1.created_at <= p2.created_at end)

#     selected_post = nil

#     socket =
#       assign(socket,
#         posts: posts,
#         main_feed: main_feed,
#         forum_name: forum_name,
#         selected_post: selected_post
#       )

#     {:ok, socket}
#   end

#   attr :main_feed, :list
#   attr :thread_name, :string, required: true

#   def render(assigns) do
#     ~H"""
#     <h1 class="text-blue-500 text-2xl font-bold mb-3 pb-3 border-b-2 outline-2">
#       <%= @forum_name %>
#     </h1>
#     <div class="flex flex-row">
#       <div>
#         <div class="p-3 outline outline-1">
#           <div data-hdl="posts-header">
#             <h2 class="text-green-800 text-xl font-bold">Posts</h2>
#           </div>
#         </div>
#         <div class="p-3 outline outline-1">
#           <ul data-hdl="posts">
#             <li :for={p <- @main_feed}>
#               <.post post={p} />
#             </li>
#           </ul>
#         </div>
#       </div>
#       <div :if={@selected_post}>
#         <.thread selected_post={@selected_post} />
#       </div>
#     </div>
#     """
#   end

#   def handle_event("select-post", value, socket) do
#     socket = assign(socket, selected_post: value)
#     {:noreply, socket}
#   end

#   def handle_event("clear-selected-post", _value, socket) do
#     socket = assign(socket, selected_post: nil)
#     {:noreply, socket}
#   end

#   attr :post, :map, required: true

#   def post(assigns) do
#     ~H"""
#     <div
#       data-hdl="post"
#       class="flex flex-row"
#       phx-click="select-post"
#       phx-value-id={@post.id}
#       phx-value-ref_post_id={@post.ref_post_id}
#     >
#       <div data-hdl="left" class="basis-1/6">
#         <div data-hdl="icon" class="border-2 rounded mt-3 p-3">img</div>
#       </div>
#       <div data-hdl="right" class="basis-5/6 border-2 rounded m-3 p-3">
#         <div data-hdl="top" class="flex flex-row">
#           <div data-hdl="username">
#             <%= @post.username %>
#           </div>
#           <div data-hdl="time">
#             <%= @post.created_at %>
#           </div>
#         </div>
#         <div data-hdl="body" class="border-y-2 my-3 py-3">
#           <%= @post.body %>
#         </div>
#         <div data-hdl="bottom" class="flex flex-row">
#           <div data-hdl="icons" class="flex flex-row">
#             <div data-hdl="icon">img</div>
#             <div data-hdl="icon">img</div>
#           </div>
#           <div data-hdl="replies">10 replies</div>
#           <div data-hdl="last-reply">last reply today</div>
#         </div>
#       </div>
#     </div>
#     """
#   end

#   attr :jump_to_post_id, :string, default: nil
#   attr :selected_post, :map, required: true

#   def thread(assigns) do
#     # get the posts in the thread

#     posts = [
#       %{
#         id: "123",
#         user_id: "234",
#         forum_id: "999",
#         username: "abc",
#         user_icon: "/images/user_icons/123.png",
#         created_at: "2022-08-11 21:06:17+03",
#         updated_at: "2022-08-11 21:06:17+03",
#         ref_post_id: nil,
#         post_to_main_feed: true,
#         body: "hello 👋 this is a post 😃"
#       },
#       %{
#         id: "545",
#         user_id: "1",
#         forum_id: "999",
#         username: "cba",
#         created_at: "2023-08-12 21:06:17+03",
#         updated_at: "2023-08-12 21:06:17+03",
#         ref_post_id: "123",
#         post_to_main_feed: true,
#         body: "🌠🚀 and 👾"
#       },
#       %{
#         id: "543",
#         user_id: "1",
#         forum_id: "999",
#         username: "cba",
#         created_at: "2023-08-11 21:06:17+03",
#         updated_at: "2023-08-11 21:06:17+03",
#         ref_post_id: "123",
#         post_to_main_feed: false,
#         body: "hi there.  this is neat. 💚"
#       }
#     ]

#     assigns = assign(assigns, posts: posts)

#     ~H"""
#     <div>
#       <div class="p-3 outline outline-1">
#         <div data-hdl="thread-header" class="flex flex-row justify-between">
#           <h2 class="text-blue-500 text-xl font-bold">Thread</h2>
#           <button
#             phx-click="clear-selected-post"
#             class="text-l font-bold border-stone-900 border-2 rounded-md px-2"
#           >
#             x
#           </button>
#         </div>
#       </div>
#       <div class="p-3 outline outline-1">
#         <ul data-hdl="thread">
#           <li :for={p <- @posts}>
#             <.thread_post post={p} highlight={p.id == @selected_post["id"]} />
#           </li>
#         </ul>
#       </div>
#     </div>
#     """
#   end

#   attr :post, :map, required: true
#   attr :highlight, :boolean

#   def thread_post(assigns) do
#     ~H"""
#     <div data-hdl="post" class={(if @highlight, do: "bg-yellow-200", else: "") <> " flex flex-row"}>
#       <div data-hdl="left" class="basis-1/6">
#         <div data-hdl="icon" class="border-2 rounded mt-3 p-3">img</div>
#       </div>
#       <div data-hdl="right" class="basis-5/6 border-2 rounded m-3 p-3 bg-purple-200">
#         <div data-hdl="top" class="flex flex-row">
#           <div data-hdl="username">
#             <%= @post.username %>
#           </div>
#           <div data-hdl="time">
#             <%= @post.created_at %>
#           </div>
#         </div>
#         <div data-hdl="body" class="border-t-2 mt-3 pt-3">
#           <%= @post.body %>
#         </div>
#       </div>
#     </div>
#     """
#   end
# end
