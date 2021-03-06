-- Original junit.lua here:
-- https://raw.githubusercontent.com/Olivine-Labs/busted/master/busted/outputHandlers/junit.lua
-- Original plain terminal here:
-- https://github.com/Olivine-Labs/busted/blob/master/busted/outputHandlers/plainTerminal.lua
local xml = require 'pl.xml'
local string = require("string")
local io = io
local say = require("say")

return function(options)
  local busted = require 'busted'
  local handler = require 'busted.outputHandlers.base'()
  local top = {
    start_tick = busted.monotime(),
    xml_doc = xml.new('testsuites', {tests = 0, errors = 0, failures = 0, skip = 0})
  }
  local output_file_name
  local stack = {}
  local testcase_node
  if 'table' == type(options.arguments) then
    -- the first argument should be the name of the xml file.
    output_file_name = options.arguments[1]
  end

  local _filename_ = ""
  local _filename_noextension_ = ""
  local _error_stack_ = {}

  -- Ref: https://github.com/Olivine-Labs/busted/blob/master/busted/outputHandlers/plainTerminal.lua#L69
  local statusString = function()
    local successString = say('output.success_plural')
    local failureString = say('output.failure_plural')
    local pendingString = say('output.pending_plural')
    local errorString = say('output.error_plural')

    local sec = handler.getDuration()
    local successes = handler.successesCount
    local pendings = handler.pendingsCount
    local failures = handler.failuresCount
    local errors = handler.errorsCount

    if successes == 0 then
      successString = say('output.success_zero')
    elseif successes == 1 then
      successString = say('output.success_single')
    end

    if failures == 0 then
      failureString = say('output.failure_zero')
    elseif failures == 1 then
      failureString = say('output.failure_single')
    end

    if pendings == 0 then
      pendingString = say('output.pending_zero')
    elseif pendings == 1 then
      pendingString = say('output.pending_single')
    end

    if errors == 0 then
      errorString = say('output.error_zero')
    elseif errors == 1 then
      errorString = say('output.error_single')
    end

    local formattedTime = ('%.6f'):format(sec):gsub('([0-9])0+$', '%1')

    return
      successes .. ' ' .. successString .. ' / ' .. failures .. ' ' .. failureString .. ' / ' ..
        errors .. ' ' .. errorString .. ' / ' .. pendings .. ' ' .. pendingString .. ' : ' ..
        formattedTime .. ' ' .. say('output.seconds')
  end

  ---@param strInput string
  ---@return string
  local replaceForwardSlash = function(strInput)
    return strInput:gsub("%./", ""):gsub("/", ".")
  end

  handler.suiteStart = function(suite, count, total)
    if suite.file then
      if (#suite.file > 1) then
        print(
          "WARNING: Since there are more than 1 file being ran, the suite name and the testcase " ..
            "classname will only use the name of the first file.")
      end
      _filename_ = replaceForwardSlash(suite.file[1].name)
      _filename_noextension_ = _filename_:gsub("%.lua", "")
    end

    -- For Jenkins Junit plugin to work, we need to make sure the testsuite name is unique
    local suite_xml = {
      start_tick = suite.starttick,
      xml_doc = xml.new('testsuite', {
        name = 'Run ' .. count .. ' of ' .. total .. "." .. _filename_noextension_,
        tests = 0,
        errors = 0,
        failures = 0,
        skip = 0,
        timestamp = os.date('!%Y-%m-%dT%H:%M:%S')
      })
    }
    top.xml_doc:add_direct_child(suite_xml.xml_doc)
    table.insert(stack, top)
    top = suite_xml

    local runString = (total > 1 and '\nRepeating all tests (run %u of %u) . . .\n' or '')
    print(runString:format(count, total))

    if (suite.file) then
      print("File(s) being ran:")
      for index, attributes in ipairs(suite.file) do
        print(string.format("  [%u] %s", index, replaceForwardSlash(attributes.name)))
      end
    end

    -- Add error tag
    if next(_error_stack_) ~= nil then
      for _, error_tag in ipairs(_error_stack_) do
        top.xml_doc:add_direct_child(error_tag)
        top.xml_doc:up()
      end
      _error_stack_ = {}
    end

    return nil, true
  end

  local function formatDuration(duration)
    return string.format("%.2f", duration)
  end

  local function elapsed(start_time)
    return formatDuration(busted.monotime() - start_time)
  end

  handler.suiteEnd = function(suite, count, total)
    local suite_xml = top
    suite_xml.xml_doc.attr.time = formatDuration(suite.duration)

    top = table.remove(stack)
    top.xml_doc.attr.tests = top.xml_doc.attr.tests + suite_xml.xml_doc.attr.tests
    top.xml_doc.attr.errors = top.xml_doc.attr.errors + suite_xml.xml_doc.attr.errors
    top.xml_doc.attr.failures = top.xml_doc.attr.failures + suite_xml.xml_doc.attr.failures
    top.xml_doc.attr.skip = top.xml_doc.attr.skip + suite_xml.xml_doc.attr.skip

    if (top.xml_doc.attr.errors > 0) or (top.xml_doc.attr.failures) > 0 then
      print("ERROR / FAILURE FOUND!")
    end
    print(statusString())
    return nil, true
  end

  handler.exit = function()
    top.xml_doc.attr.time = elapsed(top.start_tick)
    local output_string = xml.tostring(top.xml_doc, '', '\t', nil, false)
    local file
    if 'string' == type(output_file_name) then file = io.open(output_file_name, 'w+b') end
    if file then
      file:write(output_string)
      file:write('\n')
      file:close()
    else
      print(output_string)
    end
    return nil, true
  end

  local function testStatus(element, parent, message, status, trace)
    if status ~= 'success' then
      testcase_node:addtag(status)
      if status ~= 'pending' and parent and parent.randomseed then
        testcase_node:text('Random seed: ' .. parent.randomseed .. '\n')
      end
      if message then testcase_node:text(message) end
      if trace and trace.traceback then testcase_node:text(trace.traceback) end
      testcase_node:up()
    end
  end

  handler.testStart = function(element, parent)
    -- To be safe, we will use `test.filename_noextension` as a pseudo 'package' name
    testcase_node = xml.new('testcase', {
      classname = "test." .. _filename_noextension_,
      name = handler.getFullName(element),
      currentline = element.trace.currentline
    })
    top.xml_doc:add_direct_child(testcase_node)

    return nil, true
  end

  handler.testEnd = function(element, parent, status)
    top.xml_doc.attr.tests = top.xml_doc.attr.tests + 1
    testcase_node:set_attrib("time", formatDuration(element.duration))

    if status == 'success' then
      testStatus(element, parent, nil, 'success')
    elseif status == 'pending' then
      top.xml_doc.attr.skip = top.xml_doc.attr.skip + 1
      local formatted = handler.pendings[#handler.pendings]
      local trace = element.trace ~= formatted.trace and formatted.trace
      testStatus(element, parent, formatted.message, 'skipped', trace)
    end

    return nil, true
  end

  handler.failureTest = function(element, parent, message, trace)
    top.xml_doc.attr.failures = top.xml_doc.attr.failures + 1
    testStatus(element, parent, message, 'failure', trace)
    return nil, true
  end

  handler.errorTest = function(element, parent, message, trace)
    top.xml_doc.attr.errors = top.xml_doc.attr.errors + 1
    testStatus(element, parent, message, 'error', trace)
    return nil, true
  end

  handler.error = function(element, parent, message, trace)
    if element.descriptor ~= 'it' then
      _filename_ = message:match(".*%.lua")
      _filename_noextension_ = _filename_:gsub("%.lua", "")
      top.xml_doc.attr.errors = top.xml_doc.attr.errors + 1

      if string.lower(top.xml_doc.tag) == "testsuites" then
        local error_tag = xml.new('error')
        error_tag:text(message)
        if trace and trace.traceback then error_tag:text(trace.traceback) end
        table.insert(_error_stack_, error_tag)
      else
        top.xml_doc:addtag('error')
        top.xml_doc:text(message)
        if trace and trace.traceback then top.xml_doc:text(trace.traceback) end
        top.xml_doc:up()
      end
    end

    return nil, true
  end

  busted.subscribe({'exit'}, handler.exit)
  busted.subscribe({'suite', 'start'}, handler.suiteStart)
  busted.subscribe({'suite', 'end'}, handler.suiteEnd)
  busted.subscribe({'test', 'start'}, handler.testStart, {predicate = handler.cancelOnPending})
  busted.subscribe({'test', 'end'}, handler.testEnd, {predicate = handler.cancelOnPending})
  busted.subscribe({'error', 'it'}, handler.errorTest)
  busted.subscribe({'failure', 'it'}, handler.failureTest)
  busted.subscribe({'error'}, handler.error)
  busted.subscribe({'failure'}, handler.error)

  return handler
end
