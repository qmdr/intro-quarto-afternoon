-- default scores on each part
part_1 = "❌"
part_2 = "❌"
part_3 = "❌"
part_4 = "❌"
part_5 = "❌"

function Meta(x)
  -- Check for presence of author: field in yaml
  p1_bool = x.author ~= nil
  
  if p1_bool then
    part_1 = "✅"
  end
end


function Header(x)
  -- Check for ## Advanced Quarto
  is_h2 = x.level == 2
  is_aq = x.content == pandoc.Inlines({pandoc.Str("Advanced"), pandoc.Space(), pandoc.Str("Quarto")})
  
  p2_bool = is_h2 and is_aq
  if p2_bool then
    part_2 = "✅"
  end
  
end

function Link(x)
  -- Check for [Quarto](https://quarto.org/)
  is_quarto = x.content[1].text == "Quarto"
  is_quarto_org = x.target == "https://quarto.org/"
  
  p3_bool = is_quarto and is_quarto_org
  if p3_bool then
    part_3 = "✅"
  end
  
end

function BulletList(x)
  -- Check for a list with 8 items
  p4_bool = #x.content == 8
  
  if p4_bool then
    part_4 = "✅"
  end
  
end

function Image(x)
  -- Check for ![](quarto-logo.png){width="150"}
  is_png = x.src == "quarto-logo.png"
  is_150 = tonumber(x.attributes.width) == 150
  
  p5_bool = is_png and is_150
  if p5_bool then
    part_5 = "✅"
  end
  
end


function Pandoc(x)
  -- Add progress to end of document
  x.blocks:insert(pandoc.HorizontalRule())
  x.blocks:insert(pandoc.Header(4, {pandoc.Str("Progress...")}))
  x.blocks:insert(pandoc.OrderedList({pandoc.Str(part_1),
                                      pandoc.Str(part_2),
                                      pandoc.Str(part_3),
                                      pandoc.Str(part_4),
                                      pandoc.Str(part_5)}))

  -- When completed, add victory!
  if p1_bool and p2_bool and p3_bool and p4_bool and p5_bool then
    x.blocks:insert(pandoc.Header(1, pandoc.Inlines({pandoc.Str("Victory!")})))
    x.blocks:insert(pandoc.Image("", "https://upload.wikimedia.org/wikipedia/en/f/ff/SuccessKid.jpg"))
  end
  
  return(x)
end
