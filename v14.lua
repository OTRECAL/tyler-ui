local U=game:GetService("UserInputService")
local R=game:GetService("RunService")
local T=game:GetService("TweenService")
local P=game:GetService("Players").LocalPlayer
local c=P.Character or P.CharacterAdded:Wait()
local h=c:WaitForChild("HumanoidRootPart")
local m=c:WaitForChild("Humanoid")
local cm=workspace.CurrentCamera

getgenv().Sp=50 getgenv().JP=100 getgenv().En=true getgenv().UL=false
getgenv().IJ=false getgenv().Fl=false getgenv().Nc=false getgenv().AF=false
getgenv().AR=false getgenv().FU=false getgenv().AS=false getgenv().Th="Cyan"
getgenv().Cn={}
local function AC(x)table.insert(getgenv().Cn,x)end
local function Snd(i,v)
local s=Instance.new("Sound")
s.SoundId="rbxassetid://"..i
s.Volume=v or .4
s.Parent=game:GetService("SoundService")
s:Play()
game:GetService("Debris"):AddItem(s,3)
end

local sa=Instance.new("Attachment")
sa.Parent=h
local sv=Instance.new("LinearVelocity")
sv.Attachment0=sa
sv.MaxForce=math.huge
sv.VectorVelocity=Vector3.new()
sv.ForceLimitMode=Enum.ForceLimitMode.PerAxis
sv.MaxAxesForce=Vector3.new(1e5,0,1e5)
sv.Enabled=true
sv.Parent=h

AC(R.RenderStepped:Connect(function()
if getgenv().UL or not h or not h.Parent then return end
if getgenv().Fl or not sv.Enabled then
sv.VectorVelocity=Vector3.new()
return
end
if getgenv().En then
local d=m.MoveDirection
if d.Magnitude>0 then
sv.VectorVelocity=Vector3.new(d.X*getgenv().Sp,0,d.Z*getgenv().Sp)
else
sv.VectorVelocity=Vector3.new()
end
else
sv.VectorVelocity=Vector3.new()
end
end))

local jh=false
AC(U.InputBegan:Connect(function(i,g)
if g or getgenv().UL then return end
if i.KeyCode==Enum.KeyCode.Space then
jh=true
if getgenv().IJ and m and m.Parent then
m:ChangeState(Enum.HumanoidStateType.Jumping)
end
end
end))
AC(U.InputEnded:Connect(function(i)
if i.KeyCode==Enum.KeyCode.Space then jh=false end
end))
AC(R.Heartbeat:Connect(function()
if getgenv().UL then return end
if not getgenv().IJ then jh=false return end
if jh and m and m.Parent and m:GetState()~=Enum.HumanoidStateType.Jumping then
m:ChangeState(Enum.HumanoidStateType.Jumping)
end
end))

AC(U.JumpRequest:Connect(function()
if getgenv().UL then return end
if m and m.Parent and getgenv().JP>50 and h then
pcall(function()
local j=Instance.new("BodyVelocity")
j.MaxForce=Vector3.new(0,math.huge,0)
j.Velocity=Vector3.new(0,getgenv().JP,0)
j.Parent=h
game:GetService("Debris"):AddItem(j,.2)
end)
end
end))

local fb,fg
function getgenv().SF()
pcall(function()
if fb then fb:Destroy()end
if fg then fg:Destroy()end
sv.VectorVelocity=Vector3.new()
sv.Enabled=false
fb=Instance.new("BodyVelocity")
fb.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
fb.Velocity=Vector3.new()
fb.Parent=h
fg=Instance.new("BodyGyro")
fg.MaxTorque=Vector3.new(math.huge,math.huge,math.huge)
fg.P=1e4
fg.D=200
fg.CFrame=h.CFrame
fg.Parent=h
end)
end
function getgenv().EF()
pcall(function()
if fb then fb:Destroy()fb=nil end
if fg then fg:Destroy()fg=nil end
if getgenv().En then sv.Enabled=true end
end)
end

AC(R.RenderStepped:Connect(function()
if getgenv().UL or not getgenv().Fl then return end
if not h or not h.Parent or not fb or not fg then return end
local cf=cm.CFrame
local fw=cf.LookVector
local rt=cf.RightVector
local mv=Vector3.new()
if U:IsKeyDown(Enum.KeyCode.W)then mv=mv+fw end
if U:IsKeyDown(Enum.KeyCode.S)then mv=mv-fw end
if U:IsKeyDown(Enum.KeyCode.D)then mv=mv+rt end
if U:IsKeyDown(Enum.KeyCode.A)then mv=mv-rt end
local up=0
if U:IsKeyDown(Enum.KeyCode.Space)then up=1 end
if U:IsKeyDown(Enum.KeyCode.LeftShift)then up=-1 end
if mv.Magnitude>0 then mv=mv.Unit end
fb.Velocity=mv*getgenv().Sp+Vector3.new(0,up*getgenv().Sp,0)
fg.CFrame=CFrame.new(h.Position,h.Position+fw)
end))

AC(R.Stepped:Connect(function()
if getgenv().UL or not getgenv().Nc then return end
if c then
for _,v in ipairs(c:GetDescendants())do
if v:IsA("BasePart")then v.CanCollide=false end
end
end
end))

local tc={}
local lu=0
AC(R.Heartbeat:Connect(function()
if getgenv().UL or not getgenv().AF then return end
local n=tick()
if n-lu>1.5 then
lu=n
local l={}
local cp=h.Position
for _,o in ipairs(workspace:GetDescendants())do
if o:IsA("Model")and o~=c then
local hh=o:FindFirstChildOfClass("Humanoid")
local rr=o:FindFirstChild("HumanoidRootPart")or o:FindFirstChild("Torso")or o:FindFirstChildWhichIsA("BasePart")
if hh and rr and hh.Health>0 and(rr.Position-cp).Magnitude<400 then
table.insert(l,{r=rr,h=hh})
end
elseif o:IsA("BasePart")then
local nm=o.Name:lower()
if(nm:find("scroll")or nm:find("chest")or nm:find("drop")or nm:find("item"))and(o.Position-cp).Magnitude<400 then
table.insert(l,{r=o,it=true})
end
end
end
tc=l
end
local cl,md=nil,math.huge
for _,e in ipairs(tc)do
if e.r and e.r.Parent then
if e.it or(e.h and e.h.Health>0)then
local d=(e.r.Position-h.Position).Magnitude
if d<md then md=d cl=e end
end
end
end
if cl and cl.r and cl.r.Parent then
pcall(function()
if cl.it then
h.CFrame=CFrame.new(cl.r.Position+Vector3.new(0,2,0))
if cl.r:FindFirstChild("ProximityPrompt")then
fireproximityprompt(cl.r.ProximityPrompt)
end
else
h.CFrame=CFrame.new(cl.r.Position+Vector3.new(0,5,-4))
h.CFrame=CFrame.lookAt(h.Position,cl.r.Position)
local vi=game:GetService("VirtualInputManager")
local sp,on=cm:WorldToScreenPoint(cl.r.Position)
if on then
vi:SendMouseButtonEvent(sp.X,sp.Y,0,true,game,1)
task.wait(.05)
vi:SendMouseButtonEvent(sp.X,sp.Y,0,false,game,1)
end
end
end)
task.wait(.08)
end
end))

AC(h.Died:Connect(function()
if getgenv().UL or not getgenv().AR then return end
task.wait(1)
pcall(function()
local vi=game:GetService("VirtualInputManager")
for _,v in ipairs(P.PlayerGui:GetDescendants())do
if v:IsA("TextButton")and(v.Text:lower():find("respawn")or v.Text:lower():find("revive"))then
local p,s=v.AbsolutePosition,v.AbsoluteSize
vi:SendMouseButtonEvent(p.X+s.X/2,p.Y+s.Y/2,0,true,game,1)
task.wait(.05)
vi:SendMouseButtonEvent(p.X+s.X/2,p.Y+s.Y/2,0,false,game,1)
break
end
end
end)
end))

getgenv().UF=function()pcall(function()setfpscap(9999)end)end

local Th={
Cyan={m=Color3.fromRGB(12,14,20),t=Color3.fromRGB(20,24,34),a=Color3.fromRGB(0,220,255),x=Color3.fromRGB(240,245,255),s=Color3.fromRGB(0,220,255),b=Color3.fromRGB(28,32,44)},
Purple={m=Color3.fromRGB(18,12,28),t=Color3.fromRGB(28,20,42),a=Color3.fromRGB(190,90,255),x=Color3.fromRGB(248,240,255),s=Color3.fromRGB(190,90,255),b=Color3.fromRGB(38,28,52)},
Red={m=Color3.fromRGB(24,12,16),t=Color3.fromRGB(36,18,24),a=Color3.fromRGB(255,70,90),x=Color3.fromRGB(255,240,240),s=Color3.fromRGB(255,70,90),b=Color3.fromRGB(46,26,32)},
Green={m=Color3.fromRGB(10,22,16),t=Color3.fromRGB(18,34,26),a=Color3.fromRGB(0,255,140),x=Color3.fromRGB(240,255,248),s=Color3.fromRGB(0,255,140),b=Color3.fromRGB(24,44,34)},
Gold={m=Color3.fromRGB(24,20,10),t=Color3.fromRGB(36,30,16),a=Color3.fromRGB(255,200,50),x=Color3.fromRGB(255,250,235),s=Color3.fromRGB(255,200,50),b=Color3.fromRGB(46,40,22)}
}
local C=Th[getgenv().Th]

local g=Instance.new("ScreenGui")
g.Name="TylerUI"
g.ResetOnSpawn=false
g.IgnoreGuiInset=true
g.Parent=P:WaitForChild("PlayerGui")

local M=Instance.new("Frame")
M.Size=UDim2.new(0,420,0,520)
M.Position=UDim2.new(.03,0,.5,-260)
M.BackgroundColor3=C.m
M.BorderSizePixel=0
M.Active=true
M.ClipsDescendants=true
M.Parent=g
local mc=Instance.new("UICorner")mc.CornerRadius=UDim.new(0,14)mc.Parent=M
local ms=Instance.new("UIStroke")ms.Color=C.s ms.Thickness=1.5 ms.Transparency=.3 ms.Parent=M

local TB=Instance.new("Frame")
TB.Size=UDim2.new(1,0,0,48)
TB.BackgroundColor3=C.t
TB.BorderSizePixel=0
TB.Parent=M
local tbc=Instance.new("UICorner")tbc.CornerRadius=UDim.new(0,14)tbc.Parent=TB
local TF=Instance.new("Frame")
TF.Size=UDim2.new(1,0,0,14)
TF.Position=UDim2.new(0,0,1,-14)
TF.BackgroundColor3=C.t
TF.BorderSizePixel=0
TF.Parent=TB

local D=Instance.new("Frame")
D.Size=UDim2.new(0,10,0,10)
D.Position=UDim2.new(0,18,.5,-5)
D.BackgroundColor3=C.a
D.BorderSizePixel=0
D.Parent=TB
local dc=Instance.new("UICorner")dc.CornerRadius=UDim.new(1,0)dc.Parent=D

local Tt=Instance.new("TextLabel")
Tt.Size=UDim2.new(1,-160,1,0)
Tt.Position=UDim2.new(0,36,0,0)
Tt.BackgroundTransparency=1
Tt.Text="TYLER UI v15"
Tt.TextColor3=C.x
Tt.Font=Enum.Font.GothamBold
Tt.TextSize=16
Tt.TextXAlignment=Enum.TextXAlignment.Left
Tt.Parent=TB

local TH=Instance.new("TextButton")
TH.Size=UDim2.new(0,32,0,32)
TH.Position=UDim2.new(1,-80,.5,-16)
TH.BackgroundColor3=C.b
TH.Text="T"
TH.TextColor3=C.a
TH.Font=Enum.Font.GothamBold
TH.TextSize=16
TH.AutoButtonColor=false
TH.Parent=TB
local thc=Instance.new("UICorner")thc.CornerRadius=UDim.new(0,8)thc.Parent=TH

local HB=Instance.new("TextButton")
HB.Size=UDim2.new(0,32,0,32)
HB.Position=UDim2.new(1,-44,.5,-16)
HB.BackgroundColor3=C.b
HB.Text="—"
HB.TextColor3=C.x
HB.Font=Enum.Font.GothamBold
HB.TextSize=16
HB.AutoButtonColor=false
HB.Parent=TB
local hbc=Instance.new("UICorner")hbc.CornerRadius=UDim.new(0,8)hbc.Parent=HB

local tab=Instance.new("Frame")
tab.Size=UDim2.new(1,-24,0,36)
tab.Position=UDim2.new(0,12,0,58)
tab.BackgroundColor3=C.t
tab.BorderSizePixel=0
tab.Parent=M
local tabc=Instance.new("UICorner")tabc.CornerRadius=UDim.new(0,8)tabc.Parent=tab
local tl=Instance.new("UIListLayout")
tl.FillDirection=Enum.FillDirection.Horizontal
tl.Padding=UDim.new(0,4)
tl.HorizontalAlignment=Enum.HorizontalAlignment.Center
tl.VerticalAlignment=Enum.VerticalAlignment.Center
tl.Parent=tab

local pc=Instance.new("Frame")
pc.Size=UDim2.new(1,-20,1,-110)
pc.Position=UDim2.new(0,10,0,102)
pc.BackgroundTransparency=1
pc.Parent=M

local pg={}
local function cp(n)
local s=Instance.new("ScrollingFrame")
s.Size=UDim2.new(1,0,1,0)
s.BackgroundTransparency=1
s.BorderSizePixel=0
s.ScrollBarThickness=5
s.ScrollBarImageColor3=C.a
s.CanvasSize=UDim2.new()
s.AutomaticCanvasSize=Enum.AutomaticSize.Y
s.Visible=false
s.Parent=pc
local l=Instance.new("UIListLayout")l.Padding=UDim.new(0,6)l.Parent=s
pg[n]=s
end
cp("Main")cp("Movement")cp("Farm")cp("Settings")

local tbs={}
local function st(n)
for nn,p in pairs(pg)do p.Visible=(nn==n)end
for nn,b in pairs(tbs)do
local a=(nn==n)
T:Create(b,TweenInfo.new(.2),{BackgroundColor3=a and C.a or C.b}):Play()
b.TextColor3=a and Color3.new()or C.x
end
end

local function mt(n)
local b=Instance.new("TextButton")
b.Size=UDim2.new(0,90,0,28)
b.BackgroundColor3=C.b
b.Text=n
b.TextColor3=C.x
b.Font=Enum.Font.GothamBold
b.TextSize=13
b.AutoButtonColor=false
b.Parent=tab
local c=Instance.new("UICorner")c.CornerRadius=UDim.new(0,6)c.Parent=b
b.MouseButton1Click:Connect(function()Snd(9046876412,.3)st(n)end)
tbs[n]=b
end
mt("Main")mt("Movement")mt("Farm")mt("Settings")

local function mT(p,t,k,cb)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-8,0,42)
b.BackgroundColor3=C.b
b.Text=""
b.AutoButtonColor=false
b.Parent=p
local c=Instance.new("UICorner")c.CornerRadius=UDim.new(0,8)c.Parent=b
local s=Instance.new("UIStroke")s.Color=C.s s.Thickness=1 s.Transparency=.6 s.Parent=b
local l=Instance.new("TextLabel")
l.Size=UDim2.new(1,-70,1,0)
l.Position=UDim2.new(0,16,0,0)
l.BackgroundTransparency=1
l.Text=t
l.TextColor3=C.x
l.Font=Enum.Font.Gotham
l.TextSize=14
l.TextXAlignment=Enum.TextXAlignment.Left
l.Parent=b
local s2=Instance.new("Frame")
s2.Size=UDim2.new(0,40,0,22)
s2.Position=UDim2.new(1,-56,.5,-11)
s2.BackgroundColor3=getgenv()[k]and C.a or Color3.fromRGB(70,40,50)
s2.BorderSizePixel=0
s2.Parent=b
local s2c=Instance.new("UICorner")s2c.CornerRadius=UDim.new(1,0)s2c.Parent=s2
local kn=Instance.new("Frame")
kn.Size=UDim2.new(0,16,0,16)
kn.Position=getgenv()[k]and UDim2.new(1,-19,.5,-8)or UDim2.new(0,3,.5,-8)
kn.BackgroundColor3=Color3.new(1,1,1)
kn.BorderSizePixel=0
kn.Parent=s2
local knc=Instance.new("UICorner")knc.CornerRadius=UDim.new(1,0)knc.Parent=kn
b.MouseButton1Click:Connect(function()
getgenv()[k]=not getgenv()[k]
local s3=getgenv()[k]
Snd(9046876412,.4)
T:Create(s2,TweenInfo.new(.2),{BackgroundColor3=s3 and C.a or Color3.fromRGB(70,40,50)}):Play()
T:Create(kn,TweenInfo.new(.2),{Position=s3 and UDim2.new(1,-19,.5,-8)or UDim2.new(0,3,.5,-8)}):Play()
if cb then cb(s3)end
end)
end

local function mS(p,t,k,mn,mx)
local hd=Instance.new("Frame")
hd.Size=UDim2.new(1,-8,0,56)
hd.BackgroundColor3=C.b
hd.BorderSizePixel=0
hd.Parent=p
local hdc=Instance.new("UICorner")hdc.CornerRadius=UDim.new(0,8)hdc.Parent=hd
local l=Instance.new("TextLabel")
l.Size=UDim2.new(1,-80,0,22)
l.Position=UDim2.new(0,16,0,6)
l.BackgroundTransparency=1
l.Text=t
l.TextColor3=C.x
l.Font=Enum.Font.Gotham
l.TextSize=13
l.TextXAlignment=Enum.TextXAlignment.Left
l.Parent=hd
local vl=Instance.new("TextLabel")
vl.Size=UDim2.new(0,60,0,22)
vl.Position=UDim2.new(1,-70,0,6)
vl.BackgroundTransparency=1
vl.Text=tostring(getgenv()[k])
vl.TextColor3=C.a
vl.Font=Enum.Font.GothamBold
vl.TextSize=13
vl.TextXAlignment=Enum.TextXAlignment.Right
vl.Parent=hd
local sl=Instance.new("Frame")
sl.Size=UDim2.new(1,-32,0,10)
sl.Position=UDim2.new(0,16,0,34)
sl.BackgroundColor3=Color3.fromRGB(45,45,58)
sl.BorderSizePixel=0
sl.Parent=hd
local slc=Instance.new("UICorner")slc.CornerRadius=UDim.new(1,0)slc.Parent=sl
local fp=(getgenv()[k]-mn)/(mx-mn)
local f=Instance.new("Frame")
f.Size=UDim2.new(fp,0,1,0)
f.BackgroundColor3=C.a
f.BorderSizePixel=0
f.Parent=sl
local fc=Instance.new("UICorner")fc.CornerRadius=UDim.new(1,0)fc.Parent=f
local kn=Instance.new("Frame")
kn.Size=UDim2.new(0,16,0,16)
kn.Position=UDim2.new(fp,-8,.5,-8)
kn.BackgroundColor3=Color3.new(1,1,1)
kn.BorderSizePixel=0
kn.ZIndex=2
kn.Parent=sl
local knc=Instance.new("UICorner")knc.CornerRadius=UDim.new(1,0)knc.Parent=kn
local dr=false
local function u(i)
local r=i.Position.X-sl.AbsolutePosition.X
local p=math.clamp(r/sl.AbsoluteSize.X,0,1)
local v=math.floor(mn+p*(mx-mn))
getgenv()[k]=v
vl.Text=tostring(v)
f.Size=UDim2.new(p,0,1,0)
kn.Position=UDim2.new(p,-8,.5,-8)
end
sl.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true u(i)end end)
kn.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true end end)
U.InputChanged:Connect(function(i)if dr and i.UserInputType==Enum.UserInputType.MouseMovement then u(i)end end)
U.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end end)
end

local function mB(p,t,cb)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-8,0,40)
b.BackgroundColor3=C.b
b.Text=t
b.TextColor3=C.x
b.Font=Enum.Font.GothamBold
b.TextSize=14
b.AutoButtonColor=false
b.Parent=p
local c=Instance.new("UICorner")c.CornerRadius=UDim.new(0,8)c.Parent=b
b.MouseButton1Click:Connect(function()Snd(9046876412,.3)cb()end)
end

mT(pg.Main,"Speed Hack","En",function(s)sv.Enabled=s if not s then sv.VectorVelocity=Vector3.new()end end)
mS(pg.Main,"Speed","Sp",16,300)
mT(pg.Main,"Infinite Jump","IJ")
mS(pg.Main,"JumpPower","JP",50,500)
mT(pg.Main,"Fly","Fl",function(s)if s then getgenv().SF()else getgenv().EF()end end)
mT(pg.Main,"Noclip","Nc")
mT(pg.Main,"FPS Unlocker","FU",function(s)if s then getgenv().UF()end end)
mB(pg.Movement,"Reset Character",function()if c then c:BreakJoints()end end)
mT(pg.Farm,"AutoFarm","AF")
mT(pg.Farm,"Auto-Revive","AR")
mT(pg.Farm,"Auto Scroll","AS")
mB(pg.Settings,"Unload [P]",function()
getgenv().UL=true
for _,cn in ipairs(getgenv().Cn)do pcall(function()cn:Disconnect()end)end
getgenv().Cn={}
getgenv().EF()
if sv then sv:Destroy()end
if sa then sa:Destroy()end
if g then g:Destroy()end
end)

local dr,ds,sp
local function sd(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 then
dr=true ds=i.Position sp=M.Position
end
end
TB.InputBegan:Connect(sd)
tab.InputBegan:Connect(sd)
U.InputChanged:Connect(function(i)
if dr and i.UserInputType==Enum.UserInputType.MouseMovement then
local d=i.Position-ds
M.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
end
end)
U.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end end)

local TO={"Cyan","Purple","Red","Green","Gold"}
local ti=1
TH.MouseButton1Click:Connect(function()
ti=ti%#TO+1
local n=TO[ti]
getgenv().Th=n
local t=Th[n]
C=t
T:Create(M,TweenInfo.new(.3),{BackgroundColor3=t.m}):Play()
T:Create(TB,TweenInfo.new(.3),{BackgroundColor3=t.t}):Play()
T:Create(TF,TweenInfo.new(.3),{BackgroundColor3=t.t}):Play()
T:Create(ms,TweenInfo.new(.3),{Color=t.s}):Play()
T:Create(D,TweenInfo.new(.3),{BackgroundColor3=t.a}):Play()
end)
HB.MouseButton1Click:Connect(function()M.Visible=not M.Visible end)

U.InputBegan:Connect(function(i,gg)
if gg or getgenv().UL then return end
if i.KeyCode==Enum.KeyCode.K then M.Visible=not M.Visible
elseif i.KeyCode==Enum.KeyCode.P then
getgenv().UL=true
for _,cn in ipairs(getgenv().Cn)do pcall(function()cn:Disconnect()end)end
getgenv().Cn={}
getgenv().EF()
if sv then sv:Destroy()end
if sa then sa:Destroy()end
if g then g:Destroy()end
end
end)

st("Main")
M.Visible=true
print("[Tyler] v15 loaded. K=menu P=unload")
