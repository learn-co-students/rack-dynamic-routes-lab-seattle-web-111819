class Application

    @@items = [Item.new("Figs",3.42),Item.new("Pears",0.99)]

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match (/items/)
           item_name = req.path.split("/items/").last #extract item name from array using .split
           if item = @@items.find {|i| i.name == item_name} #find item in @@items array
                resp.write item.price #return the price of the item if it's in @@items array
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end