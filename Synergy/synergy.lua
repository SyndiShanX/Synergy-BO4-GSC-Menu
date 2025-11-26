LUI.createMenu["T7Hud_" .. Engine[@"GetCurrentMap"]()] = function(menu, controller)
	local self = LUI.createMenu.T7Hud_zm_factory(menu, controller)
	
	self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_menu") then
			local scriptData = CoD.GetScriptNotifyData(model)
			local element = LUI.UIImage.new(0, 0, scriptData[1], scriptData[2], 0, 0, scriptData[3], scriptData[4])			
			element:setAlpha(scriptData[5])
			
			if scriptData[6] == 100001 then
				local border = element
				border:setRGB(0.01, 1, 1)
				border:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_border") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							border:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							border:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							border:setHeight(scriptData[2])
						elseif scriptData[1] == 200008 then
							border:setLeftRight(0, 0, scriptData[2], 0)
							border:setWidth(454)
						elseif scriptData[1] == 200009 then
							border:setTopBottom(0, 0, scriptData[2], 0)
						end
					end
				end)
				self:addElement(border)
			elseif scriptData[6] == 100002 then
				local background = element
				background:setRGB(0.075, 0.075, 0.075)
				background:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_background") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							background:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							background:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							background:setHeight(scriptData[2])
						elseif scriptData[1] == 200008 then
							background:setLeftRight(0, 0, scriptData[2], 0)
							background:setWidth(450)
						elseif scriptData[1] == 200009 then
							background:setTopBottom(0, 0, scriptData[2], 0)
						end
					end
				end)
				self:addElement(background)
			elseif scriptData[6] == 100003 then
				local foreground = element
				foreground:setRGB(0.1, 0.1, 0.1)
				foreground:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_foreground") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							foreground:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							foreground:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							foreground:setHeight(scriptData[2])
						elseif scriptData[1] == 200008 then
							foreground:setLeftRight(0, 0, scriptData[2], 0)
							foreground:setWidth(450)
						elseif scriptData[1] == 200009 then
							foreground:setTopBottom(0, 0, scriptData[2], 0)
						end
					end
				end)
				self:addElement(foreground)
			elseif scriptData[6] == 100004 then
				local separator_1 = element
				separator_1:setRGB(0.01, 1, 1)
				separator_1:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_separator_1") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							separator_1:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							separator_1:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							separator_1:setHeight(scriptData[2])
						elseif scriptData[1] == 200008 then
							separator_1:setLeftRight(0, 0, scriptData[2], 0)
							separator_1:setWidth(85)
						elseif scriptData[1] == 200009 then
							separator_1:setTopBottom(0, 0, scriptData[2], 0)
							separator_1:setHeight(2)
						end
					end
				end)
				self:addElement(separator_1)
			elseif scriptData[6] == 100005 then
				local separator_2 = element
				separator_2:setRGB(0.01, 1, 1)
				separator_2:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_separator_2") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							separator_2:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							separator_2:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							separator_2:setHeight(scriptData[2])
						elseif scriptData[1] == 200008 then
							separator_2:setLeftRight(0, 0, scriptData[2], 0)
							separator_2:setWidth(85)
						elseif scriptData[1] == 200009 then
							separator_2:setTopBottom(0, 0, scriptData[2], 0)
							separator_2:setHeight(2)
						end
					end
				end)
				self:addElement(separator_2)
			elseif scriptData[6] == 100006 then
				local cursor = element
				cursor:setRGB(0.15, 0.15, 0.15)
				cursor:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_cursor") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							cursor:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							cursor:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							cursor:setHeight(scriptData[2])
						elseif scriptData[1] == 200005 then
							cursor:setTopBottom(0, 0, scriptData[2], 0)
							cursor:setHeight(32)
						elseif scriptData[1] == 200008 then
							cursor:setLeftRight(0, 0, scriptData[2], 0)
							cursor:setWidth(450)
						end
					end
				end)
				self:addElement(cursor)
			elseif scriptData[6] == 100007 then
				local scrollbar = element
				scrollbar:setRGB(0.25, 0.25, 0.25)
				scrollbar:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_scrollbar") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							scrollbar:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							scrollbar:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							scrollbar:setHeight(scriptData[2])
						elseif scriptData[1] == 200006 then
							local scrollbar_height = scrollbar:getHeight()
							scrollbar:setHeight(scrollbar_height + scriptData[2])
						elseif scriptData[1] == 200008 then
							scrollbar:setLeftRight(0, 0, scriptData[2], 0)
							scrollbar:setWidth(450)
						elseif scriptData[1] == 200009 then
							scrollbar:setTopBottom(0, 0, scriptData[2], 0)
							scrollbar:setHeight(scriptData[3])
						end
					end
				end)
				self:addElement(scrollbar)
			elseif scriptData[6] == 100020 then
				local toggle_0 = element
				toggle_0:setRGB(0.25, 0.25, 0.25)
				toggle_0:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_toggle_0") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							toggle_0:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							toggle_0:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							toggle_0:setHeight(scriptData[2])
						elseif scriptData[1] == 200008 then
							toggle_0:setLeftRight(0, 0, scriptData[2], 0)
							toggle_0:setWidth(16)
						elseif scriptData[1] == 200009 then
							toggle_0:setTopBottom(0, 0, scriptData[2], 0)
							toggle_0:setHeight(16)
						end
					end
				end)
				self:addElement(toggle_0)
			elseif scriptData[6] == 100021 then
				local toggle_1 = element
				toggle_1:setRGB(0.25, 0.25, 0.25)
				toggle_1:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_toggle_1") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							toggle_1:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							toggle_1:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							toggle_1:setHeight(scriptData[2])
						elseif scriptData[1] == 200008 then
							toggle_1:setLeftRight(0, 0, scriptData[2], 0)
							toggle_1:setWidth(16)
						elseif scriptData[1] == 200009 then
							toggle_1:setTopBottom(0, 0, scriptData[2], 0)
							toggle_1:setHeight(16)
						end
					end
				end)
				self:addElement(toggle_1)
			elseif scriptData[6] == 100022 then
				local toggle_2 = element
				toggle_2:setRGB(0.25, 0.25, 0.25)
				toggle_2:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_toggle_2") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							toggle_2:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							toggle_2:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							toggle_2:setHeight(scriptData[2])
						elseif scriptData[1] == 200008 then
							toggle_2:setLeftRight(0, 0, scriptData[2], 0)
							toggle_2:setWidth(16)
						elseif scriptData[1] == 200009 then
							toggle_2:setTopBottom(0, 0, scriptData[2], 0)
							toggle_2:setHeight(16)
						end
					end
				end)
				self:addElement(toggle_2)
			elseif scriptData[6] == 100023 then
				local toggle_3 = element
				toggle_3:setRGB(0.25, 0.25, 0.25)
				toggle_3:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_toggle_3") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							toggle_3:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							toggle_3:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							toggle_3:setHeight(scriptData[2])
						elseif scriptData[1] == 200008 then
							toggle_3:setLeftRight(0, 0, scriptData[2], 0)
							toggle_3:setWidth(16)
						elseif scriptData[1] == 200009 then
							toggle_3:setTopBottom(0, 0, scriptData[2], 0)
							toggle_3:setHeight(16)
						end
					end
				end)
				self:addElement(toggle_3)
			elseif scriptData[6] == 100024 then
				local toggle_4 = element
				toggle_4:setRGB(0.25, 0.25, 0.25)
				toggle_4:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_toggle_4") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							toggle_4:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							toggle_4:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							toggle_4:setHeight(scriptData[2])
						elseif scriptData[1] == 200008 then
							toggle_4:setLeftRight(0, 0, scriptData[2], 0)
							toggle_4:setWidth(16)
						elseif scriptData[1] == 200009 then
							toggle_4:setTopBottom(0, 0, scriptData[2], 0)
							toggle_4:setHeight(16)
						end
					end
				end)
				self:addElement(toggle_4)
			elseif scriptData[6] == 100025 then
				local toggle_5 = element
				toggle_5:setRGB(0.25, 0.25, 0.25)
				toggle_5:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_toggle_5") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							toggle_5:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							toggle_5:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							toggle_5:setHeight(scriptData[2])
						elseif scriptData[1] == 200008 then
							toggle_5:setLeftRight(0, 0, scriptData[2], 0)
							toggle_5:setWidth(16)
						elseif scriptData[1] == 200009 then
							toggle_5:setTopBottom(0, 0, scriptData[2], 0)
							toggle_5:setHeight(16)
						end
					end
				end)
				self:addElement(toggle_5)
			elseif scriptData[6] == 100026 then
				local toggle_6 = element
				toggle_6:setRGB(0.25, 0.25, 0.25)
				toggle_6:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_toggle_6") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							toggle_6:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							toggle_6:setAlpha(scriptData[2])
						elseif scriptData[1] == 200003 then
							toggle_6:setHeight(scriptData[2])
						elseif scriptData[1] == 200008 then
							toggle_6:setLeftRight(0, 0, scriptData[2], 0)
							toggle_6:setWidth(16)
						elseif scriptData[1] == 200009 then
							toggle_6:setTopBottom(0, 0, scriptData[2], 0)
							toggle_6:setHeight(16)
						end
					end
				end)
				self:addElement(toggle_6)
			elseif scriptData[6] == 100030 then
				local slider_0 = element
				slider_0:setRGB(0.25, 0.25, 0.25)
				slider_0:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_slider_0") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							slider_0:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							slider_0:setAlpha(scriptData[2])
						elseif scriptData[1] == 200004 then
							slider_0:setWidth(scriptData[2])
						elseif scriptData[1] == 200008 then
							slider_0:setLeftRight(0, 0, scriptData[2], 0)
						elseif scriptData[1] == 200009 then
							slider_0:setTopBottom(0, 0, scriptData[2], 0)
							slider_0:setHeight(32)
						end
					end
				end)
				self:addElement(slider_0)
			elseif scriptData[6] == 100031 then
				local slider_1 = element
				slider_1:setRGB(0.25, 0.25, 0.25)
				slider_1:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_slider_1") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							slider_1:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							slider_1:setAlpha(scriptData[2])
						elseif scriptData[1] == 200004 then
							slider_1:setWidth(scriptData[2])
						elseif scriptData[1] == 200008 then
							slider_1:setLeftRight(0, 0, scriptData[2], 0)
						elseif scriptData[1] == 200009 then
							slider_1:setTopBottom(0, 0, scriptData[2], 0)
							slider_1:setHeight(32)
						end
					end
				end)
				self:addElement(slider_1)
			elseif scriptData[6] == 100032 then
				local slider_2 = element
				slider_2:setRGB(0.25, 0.25, 0.25)
				slider_2:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_slider_2") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							slider_2:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							slider_2:setAlpha(scriptData[2])
						elseif scriptData[1] == 200004 then
							slider_2:setWidth(scriptData[2])
						elseif scriptData[1] == 200008 then
							slider_2:setLeftRight(0, 0, scriptData[2], 0)
						elseif scriptData[1] == 200009 then
							slider_2:setTopBottom(0, 0, scriptData[2], 0)
							slider_2:setHeight(32)
						end
					end
				end)
				self:addElement(slider_2)
			elseif scriptData[6] == 100033 then
				local slider_3 = element
				slider_3:setRGB(0.25, 0.25, 0.25)
				slider_3:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_slider_3") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							slider_3:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							slider_3:setAlpha(scriptData[2])
						elseif scriptData[1] == 200004 then
							slider_3:setWidth(scriptData[2])
						elseif scriptData[1] == 200008 then
							slider_3:setLeftRight(0, 0, scriptData[2], 0)
						elseif scriptData[1] == 200009 then
							slider_3:setTopBottom(0, 0, scriptData[2], 0)
							slider_3:setHeight(32)
						end
					end
				end)
				self:addElement(slider_3)
			elseif scriptData[6] == 100034 then
				local slider_4 = element
				slider_4:setRGB(0.25, 0.25, 0.25)
				slider_4:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_slider_4") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							slider_4:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							slider_4:setAlpha(scriptData[2])
						elseif scriptData[1] == 200004 then
							slider_4:setWidth(scriptData[2])
						elseif scriptData[1] == 200008 then
							slider_4:setLeftRight(0, 0, scriptData[2], 0)
						elseif scriptData[1] == 200009 then
							slider_4:setTopBottom(0, 0, scriptData[2], 0)
							slider_4:setHeight(32)
						end
					end
				end)
				self:addElement(slider_4)
			elseif scriptData[6] == 100035 then
				local slider_5 = element
				slider_5:setRGB(0.25, 0.25, 0.25)
				slider_5:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_slider_5") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							slider_5:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							slider_5:setAlpha(scriptData[2])
						elseif scriptData[1] == 200004 then
							slider_5:setWidth(scriptData[2])
						elseif scriptData[1] == 200008 then
							slider_5:setLeftRight(0, 0, scriptData[2], 0)
						elseif scriptData[1] == 200009 then
							slider_5:setTopBottom(0, 0, scriptData[2], 0)
							slider_5:setHeight(32)
						end
					end
				end)
				self:addElement(slider_5)
			elseif scriptData[6] == 100036 then
				local slider_6 = element
				slider_6:setRGB(0.25, 0.25, 0.25)
				slider_6:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function (model)
					if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"synergy_slider_6") then
						local scriptData = CoD.GetScriptNotifyData(model)
						if scriptData[1] == 200001 then
							slider_6:setRGB(scriptData[2] / 255, scriptData[3] / 255, scriptData[4] / 255)
						elseif scriptData[1] == 200002 then
							slider_6:setAlpha(scriptData[2])
						elseif scriptData[1] == 200004 then
							slider_6:setWidth(scriptData[2])
						elseif scriptData[1] == 200008 then
							slider_6:setLeftRight(0, 0, scriptData[2], 0)
						elseif scriptData[1] == 200009 then
							slider_6:setTopBottom(0, 0, scriptData[2], 0)
							slider_6:setHeight(32)
						end
					end
				end)
				self:addElement(slider_6)
			
			end
			
			element = nil
		end
	end)
	return self
end