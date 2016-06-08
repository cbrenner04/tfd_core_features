# frozen_string_literal: true
require './lib/pages/users/content_modules'
require './lib/pages/users/content_provider'

def content_modules
  @content_modules ||= Users::ContentModules.new(content_module: 'generic')
end

def new_content_module
  @new_content_module ||= Users::ContentModules.new(
    title: 'Test content module',
    tool: 'THINK',
    position: 8
  )
end

def test_content_module
  @test_content_module ||= Users::ContentModules.new(
    title: 'Testing content module',
    tool: 'DO',
    position: 9,
    new_tool: 'THINK'
  )
end

def another_content_module
  @another_content_module ||= Users::ContentModules.new(
    title: 'Content module for Testing'
  )
end

def final_content_module
  @final_content_module ||= Users::ContentModules.new(
    title: 'Second test module'
  )
end

def home_intro_content_module
  @home_intro_content_module ||= Users::ContentModules.new(
    title: 'Home Introduction'
  )
end

def new_content_provider
  @new_content_provider ||= Users::ContentProvider.new(
    tool: 'LEARN',
    module_title: 'Home Introduction',
    provider_type: 'Bit Core Content Providers Slideshow Provider',
    content_type: 'BitCore::Slideshow',
    provider_content: 'Home Intro',
    position: 4
  )
end

def slideshow_content_provider
  @slideshow_content_provider ||= Users::ContentProvider.new(
    title: '1 slideshow provider',
    position: 10
  )
end
