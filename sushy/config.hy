(import
    [logging [getLogger basicConfig DEBUG INFO]]
    [os [environ]]
    [os.path [join]])

(setv log (getLogger))

(def *store-path* (.get environ "CONTENT_PATH" "pages"))

(def *static-path* (.get environ "STATIC_PATH" "static"))

(def *bind-address* (.get environ "BIND_ADDRESS" "127.0.0.1"))

(def *http-port* (.get environ "PORT" "8080"))

(def *page-route-base* "/space")

(def *page-media-base* "/media")

(def *home-page* (+ *page-route-base* "/HomePage"))

(def *debug-mode* (= (.lower (.get environ "DEBUG" "false")) "true"))

(def *profiler* (= (.lower (.get environ "PROFILER" "false")) "true"))

(def *aliasing-chars* [" " "." "-" "_"])

(def *alias-page* "meta/Aliases")

(def *interwiki-page* "meta/InterWikiMap")

(def *base-types*
    {".txt"      "text/x-textile"; TODO: this should be reverted to text/plain later in the testing cycle
     ".htm"      "text/html"
     ".html"     "text/html"
     ".rst"      "text/x-rst"
     ".md"       "text/x-markdown"
     ".mkd"      "text/x-markdown"
     ".mkdn"     "text/x-markdown"
     ".markdown" "text/x-markdown"
     ".textile"  "text/x-textile"})
     
(def *base-filenames*
    (list-comp (% "index%s" t) [t (.keys *base-types*)]))

(def *base-page* "From: %(author)s\nDate: %(date)s\nContent-Type: %(markup)s\nContent-Encoding: utf-8\nTitle: %(title)s\nKeywords: %(keywords)s\nCategories: %(categories)s\nTags: %(tags)s\n%(_headers)s\n\n%(content)s")

(def *ignored-folders* ["CVS" ".hg" ".svn" ".git" ".AppleDouble" ".TemporaryItems"])

(if *debug-mode*
    (apply basicConfig [] {"level" DEBUG "format" "%(asctime)s %(thread)d %(filename)s:%(funcName)s:%(lineno)d %(levelname)s %(message)s"})
    (apply basicConfig [] {"level" INFO}))
