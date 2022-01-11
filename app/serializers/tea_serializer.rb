class TeaSerializer

  def self.tea_show(tea)
    {
      id: tea.id,
      type: 'tea',
      attributes: {
        title: tea.title,
        description: tea.description,
        temperature: tea.temperature,
        brew_time: tea.brew_time
      }
    }
  end

end
