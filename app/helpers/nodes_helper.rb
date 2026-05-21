module NodesHelper
  def node_depth_padding(node)
	depth = if node.respond_to?(:depth) && node.depth
			  node.depth
			else
			  node.ancestry.to_s.split("/").reject(&:blank?).size
			end
	depth_px = [depth * 12, 48].min
	"padding-left: #{depth_px}px;"
  end
end
