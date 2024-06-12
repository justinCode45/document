#import "@preview/polylux:0.3.1": *
#import "@preview/ctheorems:1.1.2": *
#import "/typst_packages/lecture.typ": *
#import "@preview/pinit:0.1.4": *
#import "@preview/cuti:0.2.1": show-fakebold, regex-fakeitalic
#import "@preview/fletcher:0.4.5" as fletcher: diagram,node,edge
#import "@preview/cetz:0.2.2"

#import themes.university: *
#show :show-fakebold
#show text.where(style:"italic"): t =>[
  // #regex-fakeitalic(reg-exp: "[\p{script=Han}]",t)
dsadaaaaaaaaaaaaaaaaaaaaaaaaa
]

#let uncv = uncover
#set list(marker: listal)
#set text(font: ("Times New Roman","DFKai-SB"))
#show: thmrules
#show math.equation: set text(weight: "extralight")

#show math.equation.where(block: true): e => [
	// #set block(fill: lime)
	#block(width: 100%, inset: 0.3em)[
    #set align(center)
		#set par(leading: 0.65em)
    #e

	]
]
#let pinit-highlight = pinit-highlight.with(dy: -0.7em)

#let pinit-highlight-equation-from(height: 2em, pos: bottom, fill: rgb(0, 180, 255), highlight-pins, point-pin, body) = {
  pinit-highlight(..highlight-pins, dy: -0.6em, fill: rgb(..fill.components().slice(0, -1), 40))
  pinit-point-from(
    fill: fill, pin-dx: -0.6em, pin-dy: if pos == bottom { 0.8em } else { -0.6em }, body-dx: 0pt, body-dy: if pos == bottom { -1.7em } else { -1.6em }, offset-dx: -0.6em, offset-dy: if pos == bottom { 0.8em + height } else { -0.6em - height },
    point-pin,
    rect(
      inset: 0.5em,
      stroke: (bottom: 0.12em + fill),
      {
        set text(fill: fill)
        body
      }
    )
  )
}

#let new-section-slide(title,subtitle: none) = slide([
  #set align(horizon)
  #block(width: 100%,height: 100%)[
    #text(title,size:35pt)
    #rect(width: 100%, height: 0.1em, fill: rgb("405577"))
    #align(right)[
      #text(subtitle,size:25pt)
    ]
  ]
])

#show: university-theme.with(
  color-a :rgb("405577"),
  color-b :rgb("122264"),
  color-c :rgb("C2EBD9"),
)


#title-slide(
  authors: "陽明交通大學應數系營隊",
  title: "抽象代數",
  subtitle: "群論",
  institution-name: " ",
)

#slide(title: "群論")[
  #set align(horizon)
  #block(width: 100%,height: 100%)[
    群(Group)是一個集合，並且配上一個良好的二元運算，而群論(Group Throry)是一們研究群這種結構的數學分支。群論在許多領域上有著廣泛的應用，以下介紹一些應用。
  ]
]
#slide(title: "群論的應用")[
  倍立方、化圓為方、三等分角等，尺規作圖問題。
  #grid(
    columns: (auto, auto, auto),
    rows: (3fr,2fr,5fr),
    align: horizon+center,
    grid.cell(rowspan:2,image("pic/doublecube.png")),[],
    grid.cell(rowspan:2,image("pic/angle_trisection.jpg")),
    grid.cell(rowspan:2,image("pic/squaring_circle.png"))
  )
]
#slide(title: "群論的應用")[
  我們都知道一元二次方程 $a x^2 + b x + c =0$ 的解為
  $
    x = (-b plus.minus sqrt(b^2 - 4 a c))/(2 a)
  $
  但是對於一元五次方程 $x^5 + a x^4 + b x^3 + c x^2 + d x + e = 0$，可以用群論證明，我們無法用根式解析解來表示。

]
#slide(title: "群論的應用")[
  #grid(
    gutter: 0.65em,
    columns: (auto, 1fr),
    rows: (auto, 1fr,1fr),
    align: horizon,
    grid.cell([
      除了數學上的應用外，在其他領域也有著廣泛的應用，例如
    ],colspan: 2),
    grid.cell([
      - 密碼學
      - 「李群」在近代物理中有重要作用
      - 標準粒子模型中的對稱性]),
    grid.cell([#pause#image("pic/standard_model.png")],rowspan: 2)
  )
]

#new-section-slide("群",subtitle:"Group")
#let slide = slide.with(title: "群")
#slide(title: "群",new-section: "Group")[
  #set text(size: 19pt)
  #definition(number:"1.1")[
    $angle.l G , * angle.r$是一個集合 $G$ 與一個二元運算 $* : G times G |-> G$，滿足以下條件：
    #set enum(numbering: al(n => [$cal(G)_#n$:]))
    + 對於所有的$a,b,c in G$， $ (a*b)*c = a*(b*c) quad textb("結合律") $ 

    + 存在一個元素 $e in G$，使得對於所有的 $a in G$， $ a*e = e*a = a quad textb("單位元素") $

    + 對於每一個 $a in G$，存在一個元素 $a^(-1) in G$，使得 $ a*a^(-1) = a^(-1)*a = e quad textb("反元素") $
  ]
]
#slide[
  #set text(size: 24pt)
  Example:
  - 整數集合 $ZZ$ 與加法運算 $+$ 構成一個群。 $angle.l ZZ,+ angle.r$\
    單位元素為 $0$，反元素為 $-a$。
  - 整數集合 $ZZ$ 與乘法運算 $*$ 不是一個群。\
    乘法在整數裡沒有反元素。
  - $ZZ_4 = {0,1,2,3}$ 與加法運算 $+_4$ 構成一個群。\
    其中 $+_4$ 定義為 $a +_4 b = (a+b) mod 4$。
]
#slide[
  #set text(size: 19pt)
  #definition(number:"1.2")[
    讓$G$是一個群，定義$abs(G)$是$G$的元素個數，稱為$G$的*order*。
  ]
  #definition(number:"1.3")[
    一個群$G$如果滿足交換率i.e. 對於所有的$a,b in G$，$ a*b = b*a $，則稱$G$是一個*交換群*(Abelian groups)。
  ]
  // #set text(size: 25pt)
  #pause
  Example:
  - 整數集合 $ZZ$ 與加法運算 $+$ 是一個交換群。
  - $ZZ_4$ 的 order 為 $4$。
  - 可逆矩陣的集合與矩陣乘法是一個群，但不是交換群。
]
#let slide = slide.with(title: "群的基礎性質")
#slide(new-section: "Properties of Groups")[
  #set text(size: 19pt)
  #theorem(number:"1.1")[
    如果$G$是一個群，那*消去率*成立，即對於所有的$a,b,c in G$，
    $ a*b = a*c => b = c \
       b*a = b*c => b = c $
  ]
  #pause
  #proof[
    讓$G$是一個群，$a,b,c in G$。假設$a*b = a*c$。
    #uncv("3-")[
      因為$a in G$，所以$a$的反元素$a^(-1)$存在，且$a*a^(-1) = e$。
    ]
    $
      &a*b = a*c \
      #uncv("3-")[
        $=> &#pin(1)a^(-1)*a#pin(2)*b = #pin(3)a^(-1)*a#pin(4)*c \ $
      ]
      #uncv("5-")[
        $=> &e*b = e*a\ $
      ]
      #uncv("2-")[
        $=> &b = a$
      ] 
    $
  ]
  #uncv("4-")[
    #pinit-highlight(1,2)
    #pinit-highlight(3,4)
  ]
  
]
#slide(new-section: "Properties of Groups")[
  #set text(size: 19pt)
  #theorem(number: "1.2")[
    群$G$的單位元素$e$唯一。
  ]
  #pause
  #proof[
    假設存在第二個單位元素$e_2$，滿足對於所有$a in G$
    $ e_2*a = a*e_2 = a $
    因為$e in G$，所以
    #only(2)[
      $ e_2 * a = a $
    ]
    #only("3-")[ 
      $ #pin(1)e_2 * e#pin(2) = e $
    ]
    #uncv("4-")[
      #pinit-highlight-equation-from((1,2),2)[$= e_2$]
    ]
    #uncv("5-")[
      我們得到$e_2 = e$
    ]
  ]
  
]
#slide[
  #set text(size: 19pt)
  #theorem(number:"1.3")[
    讓$G$是一個群，$a b in G$，那麼
    $
      (a b)^(-1) = b^(-1) a^(-1)
    $
  ]
  #pause
  #proof[
    我們直接相乘
    $
        (a b)b^(-1) a^(-1) &= a (b b^(-1)) a^(-1) \
                           &= a e a^(-1)\
                         &= a a^(-1)\
                         &= e
    $
    根據反元素的定義，$(a b)^(-1) = b^(-1) a^(-1)$
  ]
]

#new-section-slide("置換群",subtitle:"Permutation Group")
#slide(title:"置換")[
  $
    A = {1,2,3,4,5}\
    #uncv("2-")[
      $ 
        arrow.b  sigma textr("排列")\
        A = {3,1,5,2,4}
      $
    ]
  $
  #pause
  #pause
  #grid(
    columns: (1fr,1fr),
    rows: (auto),
    align: center,
    [#figure(
      $
        1 -> 3\
        2 -> 4\
        3 -> 5\
        4 -> 2\
        5 -> 1
      $,
      caption: [$sigma$],
    ) <fig1>],
    [#figure(
      $
        1 -> 2\
        2 -> 3\
        3 -> 2\
        4 -> 5\
        5 -> 1\
      $,
    )<fig2>]
  )
]

#slide(title:"置換")[
  #set text(size: 19pt)
  #definition(number:"2.1")[
    一個$A$的是*置換*是一個一一對應的函數 $phi : A -> A$。 (one-one and onto)
  ]
  #set text(size: 25pt)
  #grid(
    columns: (1fr,1fr),
    rows: (auto),
    align: center,
    [#figure(
      $
        1 -> 3\
        2 -> 4\
        3 -> 5\
        4 -> 2\
        5 -> 1
      $,
      caption: [一個置換 $sigma$], 
    ) <fig1>],
    [#figure(
      $
        1 -> 2\
        2 -> 3\
        3 -> 2\
        4 -> 5\
        5 -> 1\
      $,
      caption: "不是置換",
    )<fig2>]
  )
]
#slide(title:"置換的合成")[
  #set text(size: 19pt)
  #definition(number:none)[
    讓$sigma$和$tau$是兩個置換，定義$sigma$和$tau$的*合成*是一個新的置換$sigma cir tau$，使得對於所有的$a in A$，
    $ (sigma cir tau)(a) = sigma(tau(a)) $
  ]
  #pause
  #set text(size: 25pt)
  $ 
  (sigma cir tau)(x) = sigma(tau(x)) \
  A -->^tau A -->^sigma A
  $
  因為$sigma$和$tau$都是一一對應的函數，所以$sigma cir tau$也是一一對應的函數。\
  所以 $sigma cir tau$ 是一個置換。
]
#let msigma = $mat(
    1, 2, 3, 4, 5;
    3, 4, 5, 2, 1
  )$
#let mtau = $mat(
    1, 2, 3, 4, 5;
    2, 3, 4, 5, 1
  )$
#slide(title:"Eaxmple 置換")[
  #grid(
    columns: (1fr,1fr),
    rows: (auto),
    align: center,
    $ sigma = msigma $,
    $ tau = mtau $
  )
  #pause
  #v(-0.5em)
  $
    sigma cir tau 
    = msigma cir mtau 
    = mat(
      1, 2, 3, 4, 5;
      4, 5, 2, 1, 3
    )
  $
  #pause
  #align(center)[
    #diagram(spacing: (5em,0.3em),{
      let nd(x) = ((x,0), (x,1), (x,2), (x,3), (x,4))
      for x in range(3){
        for y in range(5){
          node((x,y), [#(y+1)])
        }
      }
      node((0.5,0),[#show math.equation: set text(fill: teal);$tau$])
      node((1.5,0),[#show math.equation: set text(fill: red);$sigma$])
      node(enclose:nd(0)+nd(1),stroke: teal)
      node(enclose:nd(1)+nd(2),stroke: red)
      let edgearr = (
        ((0,0),(1,1)),
        ((0,1),(1,2)),
        ((0,2),(1,3)),
        ((0,3),(1,4)),
        ((0,4),(1,0)),

        ((1,0),(2,2)),
        ((1,1),(2,3)),
        ((1,2),(2,4)),
        ((1,3),(2,1)),
        ((1,4),(2,0))
      )
      for e in edgearr{
        edge(e.at(0),e.at(1),"->")
      }
    })
  ]
]
#slide(title: "置換群")[
  #set text(size: 19pt)
  #definition(number:"2.2")[
    一個集合$A$的所有置換構成一個_群_，稱為$A$的*置換群*，記為$S_A$。
  ]
  #pause
  #set text(size: 25pt)
  #remark[
    $n$個元素的集合的置換群計為$S_n$的order為$n!$。
  ]
  #pause
  #example[
    \
    上述的例子中，$tau$和$sigma$是$S_5$的元素。\
    $S_5$的order為$5! = 120$。
  ]
]
#slide(title: "循環表示法(Cycle)")[
  $ sigma = mat(1, 2, 3, 4, 5; 3, 4, 5, 2, 1) $
  #pause
  #v(2em)
  #only(2)[
    #grid(
      columns: (1fr,1fr),
      rows: (auto),
      align: center,
      diagram(
        {
          // traingle
          let (p1,p3,p5) = ((0,0),(1,0),(0.5,0.866))
          node(p1,[*1*])
          node(p3,[*3*])
          edge(p1,p3,"->",bend: 55deg)

        }
      ),
      diagram(
        {
          // traingle
          let (p2,p4) = ((0,0),(1,0))
          node(p2,[*2*])
          node(p4,[*4*])
          edge(p2,p4,"->",bend: 55deg)
        }
      )
    )
  ]
  #only(3)[
    #grid(
      columns: (1fr,1fr),
      rows: (auto),
      align: center,
      diagram(
        {
          // traingle
          let (p1,p3,p5) = ((0,0),(1,0),(0.5,0.866))
          node(p1,[*1*])
          node(p3,[*3*])
          node(p5,[*5*])
          edge(p1,p3,"->",bend: 55deg)
          edge(p3,p5,"->",bend: 55deg)
        }
      ),
      diagram(
        {
          // traingle
          let (p2,p4) = ((0,0),(1,0))
          node(p2,[*2*])
          node(p4,[*4*])
          edge(p2,p4,"->",bend: 55deg)
          edge(p4,p2,"->",bend: 55deg)
        }
      )
    )
  ]
  #only("4-")[
    #grid(
      columns: (1fr,1fr),
      rows: (auto),
      align: center,
      diagram(
        {
          // traingle
          let (p1,p3,p5) = ((0,0),(1,0),(0.5,0.866))
          node(p1,[*1*])
          node(p3,[*3*])
          node(p5,[*5*])
          edge(p1,p3,"->",bend: 55deg)
          edge(p3,p5,"->",bend: 55deg)
          edge(p5,p1,"->",bend: 55deg) 
        }
      ),
      diagram(
        {
          // traingle
          let (p2,p4) = ((0,0),(1,0))
          node(p2,[*2*])
          node(p4,[*4*])
          edge(p2,p4,"->",bend: 55deg)
          edge(p4,p2,"->",bend: 55deg)
        }
      )
    )
  ]
  #uncv("5-")[
    $
      sigma = (1,3,5)(2,4)
    $
  ]
]

#new-section-slide("空間對稱群",subtitle:"Symmetry Group")
#let (p1,p2,p3) = ((0,0),(1,0),(0.5,-0.866))

#slide(title:"對稱群")[
  #set figure(supplement: none)
  我們接下來考慮一種特殊的置換群。\
  #pause
  #grid(
    columns: (1fr,1fr,1fr),
    rows: (auto),
    align: center,
    uncv("2-")[#figure(
      diagram(
        {
          node(p1,[*1*])
          node(p2,[*2*])
          node(p3,[*3*])
          edge(p1,p2,"-")
          edge(p2,p3,"-")
          edge(p3,p1,"-")
        }
      ),
      caption: "正三角形", 
    )],
    uncv("3-")[#figure(
      diagram({
        node(p1,[*2*])
        node(p2,[*3*])
        node(p3,[*1*])
        edge(p1,p2,"-")
        edge(p2,p3,"-")
        edge(p3,p1,"-")

      }),
      caption: [順時針旋轉 $120$ 度],
    )],
    uncv("4-")[#figure(
      diagram({
        node(p1,[*1*])
        node(p2,[*3*])
        node(p3,[*2*])
        edge(p1,p2,"-")
        edge(p2,p3,"-")
        edge(p3,p1,"-")
        let mid = ((p2.at(0)+p3.at(0))/1.9,(p2.at(1)+p3.at(1))/1.9)
        edge((0,0),mid,stroke: red)
      }),
      caption: [沿某一軸鏡射],
    )]
  ) 
  #grid(
    columns: (1fr,1fr),
    rows: (100pt),
    align: center+horizon,
    uncv("3-")[$rho_1 = mat(1,2,3; 2,3,1) = (1,2,3)$],
    uncv("4-")[$tau_1 = mat(1,2,3; 1,3,2) = (1)(2,3)$]
  )
  #uncv("5-")[
    我們稱這些置換為*對稱置換*。
  ]
]
#slide(title:"對稱群")[
  #set figure(supplement: none)
  // #set text(size: 25pt)
  #grid(
    columns: (1fr,1fr),
    rows: (20%),
    align: center+horizon,
    $rho_1 = mat(1,2,3; 2,3,1) = (1,2,3)$,
    $tau_1 = mat(1,2,3; 1,3,2) = (1)(2,3)$
  )
  #set text(size: 20pt)
  #grid(
    columns: (1fr,1fr,1fr),
    rows: (auto),
    align: center,
    [#figure(
      diagram(
        {
          node(p1,[*1*])
          node(p2,[*2*])
          node(p3,[*3*])
          edge(p1,p2,"-")
          edge(p2,p3,"-")
          edge(p3,p1,"-")
        }
      ),
      caption: "正三角形", 
    )],
    [#figure(
      diagram({
        node(p1,[*2*])
        node(p2,[*3*])
        node(p3,[*1*])
        edge(p1,p2,"-")
        edge(p2,p3,"-")
        edge(p3,p1,"-")

      }),
      caption: [$rho_1$],
    )],
    [#figure(
      diagram({
        node(p1,[*2*])
        node(p2,[*1*])
        node(p3,[*3*])
        edge(p1,p2,"-")
        edge(p2,p3,"-")
        edge(p3,p1,"-")
        edge(p3,(0.5,0.1),stroke: red)
      }),
      caption: [$tau_1 cir rho_1$],
    )]
  )
  #set text(size: 25pt)
  #align(center)[
    $
      tau_1 cir rho_1 &= mat(1,2,3;1,3,2) mat(1,2,3;2,3,1) 
      &= mat(1,2,3;3,1,2) 
      &= (1,3,2)
    $
  ]
  #pause
  對稱置換的#underline("合成")還是一個對稱置換。
]
#slide(title:[$D_3$])[
  我們把三角形的所有對稱的置換枚舉出來：
  #set text(size: 21pt)
  $
    e = rho_0 &= (1)(2)(3)  & textr("不動")\
    rho_1 &= (1,2,3) & textr("旋轉 120 度") \
    rho_2 &= (1,3,2) & textr("旋轉 240 度") \
    tau_1 &= (1)(2,3) & textr("鏡射") \
    tau_2 &= (1,3,2) & textr("鏡射") \
    tau_3 &= (1,2)(3) & textr("鏡射") \
  $
  #pause
  #set text(size: 25pt)
  把上述的對稱置換構成的群稱為$D_3$，稱為*正三角形的空間對稱群*。
]
#slide(title:[$D_3$])[
  $
    D_3 = {e, rho_1, rho_2, tau_1, tau_2, tau_3} 
  $
  #set table(stroke: (x,y) =>(
    bottom: if y==0  {1pt},
    right: if x==0 {1pt},
  ))
  #figure(
    table(
      align: center,
      columns: (2em,2em,2em,2em,2em,2em,2em),
      $cir$, $e$, $rho_1$, $rho_2$, $tau_1$, $tau_2$, $tau_3$,
      $e$, $e$, $rho_1$, $rho_2$, $tau_1$, $tau_2$, $tau_3$,
      $rho_1$, $rho_1$, $rho_2$, $e$, $tau_3$, $tau_1$, $tau_2$,
      $rho_2$, $rho_2$, $e$, $rho_1$, $tau_2$, $tau_3$, $tau_1$,
      $tau_1$, $tau_1$, $tau_3$, $tau_2$, $e$, $rho_2$, $rho_1$,
      $tau_2$, $tau_2$, $tau_1$, $tau_3$, $rho_2$, $e$, $rho_1$,
      $tau_3$, $tau_3$, $tau_2$, $tau_1$, $rho_1$, $rho_2$, $e$
    )
  )
]
#slide(title:[$D_4$])[

  #grid(
    columns: (1fr,1fr),
    rows: (auto),
    align: center,
    [
      $
        D_4 = {e, rho_1, rho_2, rho_3, tau_1, tau_2, tau_3, tau_4}
      $
      #v(20%)
      #figure(
        diagram({
          node((0,0),[1])
          node((1,0),[2])
          node((1,1),[3])
          node((0,1),[4])
          edge((0,0),(1,0),"-")
          edge((1,0),(1,1),"-")
          edge((1,1),(0,1),"-")
          edge((0,1),(0,0),"-")

          node((0.5,-0.5),[#set text(fill: red);$tau_3$])
          edge((0.5,-0.1),(0.5,1.1),"-",stroke: red)
          
          node((-0.5,0.5),[#set text(fill: lime);$tau_4$])
          edge((-0.1,0.5),(1.1,0.5),"-",stroke: lime)
          
          node((1.5,-0.5),[#set text(fill: teal);$tau_2$])
          edge((1,0),(0,1),"-",stroke: teal)
          
          node((-0.5,-0.5),[#set text(fill: purple);$tau_1$])
          edge((0,0),(1,1),"-",stroke: purple)
        })
      )
    ],
    [
      $
        e &= (1)(2)(3)(4) \
        rho_1 &= (1,2,3,4)\
        rho_2 &= (1,3)(2,4)\
        rho_3 &= (1,4,3,2)\
        tau_1 &= (1)(2,4)(3)\
        tau_2 &= (1,3)(2)(4)\
        tau_3 &= (1,2)(4,3)\
        tau_4 &= (1,4)(2,3)\
      $
    ]
  )
]
#slide(title:[$D_4$])[
  #set figure(supplement: none)

  值得注意的是 $sigma = (1,2)(4)(3)$ 他是一個置換，但不是一個對稱置換，因為他不能把正方形打回自身。
  #v(20%)
  #let (p1,p2,p3,p4) = ((0,0),(1,0),(1,1),(0,1))
  #grid(
    columns: (1fr,1fr,1fr),
    rows: (auto),
    figure(
      diagram({
        node(p1,[*1*])
        node(p2,[*2*])
        node(p3,[*3*])
        node(p4,[*4*])
        edge(p1,p2,"-")
        edge(p2,p3,"-")
        edge(p3,p4,"-")
        edge(p4,p1,"-")
      }),
      caption: "正方形"
    ),
    figure(
      diagram({
        node(p1,[*3*])
        node(p2,[*4*])
        node(p3,[*1*])
        node(p4,[*2*])
        edge(p1,p2,"-")
        edge(p2,p3,"-")
        edge(p3,p4,"-")
        edge(p4,p1,"-")
      }),
      caption: [$rho_2$]
    ),
    figure(
      diagram({
        node(p1,[*2*])
        node(p2,[*1*])
        node(p3,[*3*])
        node(p4,[*4*])
        edge(p1,p2,"-")
        edge(p2,p4,"-")
        edge(p3,p4,"-")
        edge(p3,p1,"-")
      }),
      caption: [$sigma$ 不是一個對稱置換]
    )
  ) 
]
#slide(title: "如何計算空間對稱群")[
  正$n$邊形的對稱群的order是#only("1")[多少?]#only("2")[ $2n$]。\
  立方體的有#only("1")[多少]#only("2")[$24$個]不同的旋轉。
  #set align(center)
  #cetz.canvas(length: 90pt,{
      import cetz.draw:*
      ortho(x:20deg,y:45deg,z:0deg,{
        
        on-xy(z:-1,{
          rect((-1,-1),(1,1),fill: rgb("e8e8f8"))
        })
        on-xy(z:1,{
          rect((-1,-1),(1,1),fill: rgb(silver))
        })
        on-yz(x:-1,{
          rect((-1,-1),(1,1))
        })
        on-yz(x:1,{
          rect((-1,-1),(1,1))
        })
        on-xz(y:-1,{
          rect((-1,-1),(1,1))
        })
        on-xz(y:1,{
          rect((-1,-1),(1,1))
        })
      })
    })
]
#new-section-slide("作用群",subtitle:"Group Action")
#let gset = $G negspace textb("-set")$
#slide(title: "作用群")[
  #set text(size: 19pt)

  #definition(number:"4.1")[
    一個群$G$對一個集合$A$的*作用*是一個映射 $* : G times A -> A$，滿足以下條件：
    #set enum(numbering: al("1."))
    + 對於所有 $a in A quad e a = a$
    + 對於所有 $a in A$ 和 $g,h in G$，$(g h)a = g(h a)$

    在這個情況下，我們稱$A$是一個#gset。
  ]
  像是在上一章節中，我們考慮了對稱群$D_3$對正三角形的作用。
]
#slide(title:"作用群")[
  #set text(size: 19pt)
  #theorem(number:"4.1")[
    讓$X$是一個#gset。如果$g x_1 = g x_2$，那$x_1 = x_2$
  ]
  #proof[
    假設 $g x_1 = g x_2$，那麼 $g^(−1)g x_1 = g^(−1) g x_2$，所以 $e x_1 = e x_2$，所以 $x_1 = x_2$。
  ]
  #remark[
    如果$x != y$，那$g x != g y$
  ]
]
#let Stab = math.op("Stab")
#slide(title: "不動點、穩定子群、軌道")[
  *Fixed point, Stabilizers subgroup, Orbits*
  #set text(size: 19pt)

  #definition(number: "4.2")[
    讓$X$是一個#gset，讓$x in X$，$g in G$。我們定義；
    $
      Stab_G (x) = {g in G | g x = x} \
      X^g = {x in X | g x = x}
    $
    $Stab_G (x)$稱為$x$的*穩定子群*，$X^g$稱為$g$的*不動點*。
  ]

]
