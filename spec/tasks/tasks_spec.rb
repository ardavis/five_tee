require "rails_helper"

RSpec.describe Task, type: :modal do

  context 'can be completed' do

    let(:task) { Task.create(title: 'Test', completed_at: nil) }

    it 'if it was not started' do
      expect(task.completed_at).to be nil
      task.complete!
      expect(task.completed_at).to_not be nil
    end

    it 'if it was started' do
      task.update_attributes(started_at: Time.now)
      expect(task.completed_at).to be nil
      task.complete!
      expect(task.completed_at).to_not be nil
      expect(task.started_at).to be nil
    end

  end

end